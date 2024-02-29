import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool isLogin = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
