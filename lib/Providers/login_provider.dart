import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Constants/url_const.dart';
import 'package:real_time_chatting/Models/users_model.dart';
import 'package:real_time_chatting/Utils/local_storage.dart';
import 'package:real_time_chatting/Constants/local_const.dart';
import 'package:real_time_chatting/Models/user.dart';

final loginProvider =
    ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());
final userDataProvider = FutureProvider<List<User>>((ref) async {
  return ref.watch(loginProvider).getUsers();
});

class LoginProvider extends ChangeNotifier {
  bool isLogin = false;
  String mailError = '';
  String pswError = '';
  String confError = '';
  String nameError = '';
  List<User> users = [];
  late fb_auth.UserCredential credential;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswController = TextEditingController();
  final TextEditingController confpswController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

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

  void showNameError(String value) {
    nameError = value;
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

  Future<void> storeInfoToLocal(User user) async {
    await StorageUtils.putString(lUserInfo, userToJson(user));
    await StorageUtils.putBool(lisLogin, true);
  }

  Future<User> getUserFromLocal() async {
    String userDataString = await StorageUtils.getString(lUserInfo);
    return userFromJson(userDataString);
  }

  Future<List<User>> getUsers() async {
    final String token = await getAgoraChatAppTempToken();
    const String apiUrl = 'https://$host/$orgName/$appName/users';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http
        .get(
      Uri.parse(apiUrl),
      headers: headers,
    )
        .catchError((onError) {
      throw Exception('Failed to load agora create user');
    });
    debugPrint("response status${response.statusCode}");
    if (response.statusCode == 200) {
      UsersModel userModel = usersModelFromJson(response.body);
      users = userModel.entities;
      notifyListeners();
    }
    return users;
  }

  Future<bool> createAccountToAgora() async {
    final String token = await getAgoraChatAppTempToken();
    const String apiUrl = 'https://$host/$orgName/$appName/users';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      "username": credential.user!.uid,
      "password": pswController.text,
      "nickname": nameController.text,
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
      credential =
          await fb_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: pswController.text,
      );
      result = true;
    } on fb_auth.FirebaseAuthException catch (e) {
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

  Future<bool> signIn() async {
    bool result = false;
    try {
      credential = await fb_auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: pswController.text);
      User userData = User(
          email: credential.user!.email ?? "",
          passowrd: pswController.text,
          username: credential.user!.uid);
      storeInfoToLocal(userData);
      result = true;
    } on fb_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMailError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showPswError('Wrong password provided for that user.');
      }
    }
    return result;
  }

  void clearAfterSignUp() {
    emailController.clear();
    pswController.clear();
  }

  void disposeTextControllers() {
    emailController.dispose();
    pswController.dispose();
    confpswController.dispose();
    nameController.dispose();
  }

  bool isValidName(String value) {
    String allowedCharString =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ';
    List<String> allowedCharList = allowedCharString.split("");
    for (int i = 0; i < value.length; i++) {
      bool isValid = allowedCharList.contains(value[i]);
      if (!isValid) return false;
    }
    return true;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      showNameError("Please enter name");
      return null;
    } else if (!isValidName(value)) {
      showNameError("Invalid name");
      return null;
    }
    nameError = "";
    notifyListeners();
    return null;
  }
}
