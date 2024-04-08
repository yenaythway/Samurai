import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_chatting/Constants/url_const.dart';

class LoginProvider extends ChangeNotifier {
  bool isLogin = false;
  String mailError = '';
  String pswError = '';
  String confError = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswController = TextEditingController();
  final TextEditingController confpswController = TextEditingController();

  bool isValidEmailFormat() {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(emailController.text);
  }

  void showMailError(String value) {
    mailError = value;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      showMailError("Please enter gmail");
      return null;
    }
    if (!isValidEmailFormat()) {
      showMailError("Invalid mail");
      return null;
    }
    return "";
  }

  bool checkPswLength() => pswController.text.length < 6;

  void showPswError(String value) {
    pswError = value;
    notifyListeners();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      showPswError("Please enter password");
      return null;
    }
    if (checkPswLength()) {
      showPswError("Enter more than 6 character");
      return null;
    }
    return "";
  }

  String? validateConfPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please  enter confirm passowrd";
    }
    if (pswController.text != confpswController.text) {
      return "Password not same";
    }
    return "";
  }

  Future<bool> createAccountToAgora() async {
    final String token = await getAgoraChatAppTempToken();
    const String apiUrl = 'https://$host/$orgName/$appName/users';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      "username": emailController.text,
      "password": confpswController.text,
      "nickname": emailController.text
    };

    final response = await http
        .post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode(requestBody),
    )
        .catchError((onError) {
      throw Exception('Failed to load agora create user');
    });
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["entities"].toString().isNotEmpty) {
        final bool msg = result["entities"][0]["activated"];
        debugPrint("msg$msg");
        return msg;
      }
    }

    return false;
  }

  Future<String> getAgoraChatAppTempToken() async {
    String url =
        "https://raw.githubusercontent.com/yenaythway/agoraTokenForRTC/main/token.json";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      debugPrint('result-$result');
      return result;
    }
    return "";
  }

  Future<void> signUp() async {
    print("::::::::::::1");
    // late UserCredential credential;
    print("::::::::::::");
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: pswController.text,
      );
      print(
          "!!!!!!${credential.additionalUserInfo}//${credential.user}//${credential.credential}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showMailError("User already exists with this mail");
      }
    } catch (e) {
      debugPrint("$e");
    }

    // createAccountToAgora();
  }

  void signIn() {}
}
