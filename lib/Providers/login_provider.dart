import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  User? getUserFromLocal() {
    Box<User> box = Hive.box('userData');
    return box.get('user');
  }

  Future<bool> createAccountToAgora() async {
    User? user = getUserFromLocal();
    if (user == null) return false;
    final String token = await getAgoraChatAppTempToken();
    const String apiUrl = 'https://$host/$orgName/$appName/users';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      "username": user.email,
      "password": user.uid,
      "nickname": user.email
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

  Future<bool> signUp() async {
    late UserCredential credential;
    bool result = false;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: pswController.text,
      );
      // storeUserToLocal(credential.user);
      await createUser(credential.user!);
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

  void storeUserToLocal(User? user) {
    Box box = Hive.box('userinfo');
    box.put('user', user);
    print("0000${box.get('user')}");
  }

  Future<void> createUser(User user) async {
    print("it is here");
    final box = Hive.box('userinfo');
    print("after open");
    await box.put("user", user);
    print("0000${box.get('user')}");
  }

  void signIn() {}
  void clearAfterSignUp() {
    // emailController.clear();
    emailController.dispose();
    // pswController.clear();
    pswController.dispose();
    //  confpswController.clear();
    confpswController.dispose();
  }
}
