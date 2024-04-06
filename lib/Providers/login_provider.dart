import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_chatting/Constants/url_const.dart';

class LoginProvider extends ChangeNotifier {
  bool isLogin = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pswController = TextEditingController();
  final TextEditingController confpswController = TextEditingController();
  Future<bool> createAccountToAgora() async {
    final String token = await getAgoraChatAppTempToken();
    const String apiUrl = 'https://$host/$orgName/$appName/users';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> requestBody = {
      "username": usernameController.text,
      "password": confpswController.text,
      "nickname": usernameController.text
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

  void signUp() {
    createAccountToAgora();
  }

  void signIn() {}
}
