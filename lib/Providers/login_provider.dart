import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_chatting/Constants/local_const.dart';
import 'package:real_time_chatting/Constants/url_const.dart';
import 'package:real_time_chatting/Models/user_info_model.dart';
import 'package:real_time_chatting/Utils/local_storage.dart';

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
    } else if (!isValidEmailFormat()) {
      showMailError("Invalid mail");
      return null;
    }
    mailError = "";
    notifyListeners();
    return null;
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
    } else if (checkPswLength()) {
      showPswError("Enter more than 6 character");
      return null;
    }
    pswError = "";
    notifyListeners();
    return null;
  }

  String? validateConfPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please  enter confirm passowrd";
    } else if (pswController.text != confpswController.text) {
      return "Password not same";
    }
    confError = "";
    notifyListeners();
    return null;
  }

  void storeUserToLocal(UserData user) {
    StorageUtils.putString(lUserInfo, userDataToJson(user));
  }

  Future<UserData> getUserFromLocal() async {
    String userDataString = await StorageUtils.getString(lUserInfo);
    return userDataFromJson(userDataString);
  }

  Future<bool> createAccountToAgora() async {
    UserData user = await getUserFromLocal();
    final String token = await getAgoraChatAppTempToken();
    const String apiUrl = 'https://$host/$orgName/$appName/users';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      "username": user.uid,
      "password": user.passowrd,
      "nickname": user.uid,
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
    debugPrint("response status${response.statusCode}");
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["entities"].toString().isNotEmpty) {
        final bool msg = result["entities"][0]["activated"];
        return msg;
      }
    } else if (response.statusCode == 400) {
      showMailError("User already exists with this mail");
      return false;
    }
    return false;
  }

  Future<String> getAgoraChatAppTempToken() async {
    String url =
        "https://raw.githubusercontent.com/yenaythway/agoraTokenForRTC/main/token.json";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    }
    return "";
  }

  Future<bool> signUp() async {
    bool result = false;
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: pswController.text,
      );
      UserData userData = UserData(
          email: credential.user!.email ?? "",
          passowrd: pswController.text,
          uid: credential.user!.uid);
      storeUserToLocal(userData);
      result = await createAccountToAgora();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showPswError('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showMailError("User already exists with this mail");
      }
    } catch (e) {
      debugPrint("$e");
    }
    return result;
  }

  void signIn() {}
  void clearAfterSignUp() {
    emailController.clear();
    pswController.clear();
    confpswController.clear();
  }

  void disposeTextControllers() {
    emailController.dispose();
    pswController.dispose();
    confpswController.dispose();
  }
}
