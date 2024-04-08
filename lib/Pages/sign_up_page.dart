import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';
import 'package:real_time_chatting/Utils/extension.dart';
import 'package:real_time_chatting/Utils/super_scaffold.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/login.png",
                ))),
        child: SuperScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SignUpForm(formKey: formKey, loginProvider: loginProvider),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.loginProvider,
  });

  final GlobalKey<FormState> formKey;
  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Selector<LoginProvider, String>(
              selector: (context, counterModel) => counterModel.mailError,
              builder: (context, e, _) {
                return CustomTextField(
                  name: "Gmail",
                  controller: loginProvider.emailController,
                  errorText: e,
                  validator: (value) => loginProvider.validateEmail(value),
                );
              },
            ),
            Selector<LoginProvider, String>(
              selector: (context, counterModel) => counterModel.pswError,
              builder: (context, e, _) {
                return CustomTextField(
                  name: "Passowrd",
                  obscureText: true,
                  errorText: e,
                  controller: loginProvider.pswController,
                  validator: (value) => loginProvider.validatePassword(value),
                );
              },
            ),
            Selector<LoginProvider, String>(
              selector: (context, counterModel) => counterModel.confError,
              builder: (context, e, _) {
                return CustomTextField(
                  name: "Confirm Passowrd",
                  obscureText: true,
                  errorText: e,
                  controller: loginProvider.confpswController,
                  validator: (value) =>
                      loginProvider.validateConfPassword(value),
                );
              },
            ),
            GestureDetector(
              onTap: () async {
                print("######${formKey.currentState!.validate()}");
                if (formKey.currentState!.validate()) {
                  print("before");
                  await loginProvider.signUp();
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(color: Colors.white),
                  width: double.infinity,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider()),
                Text(
                  " or continue with ",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Image.asset(
                "assets/google.png",
                height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? name;
  final bool isConPsw;
  final bool obscureText;
  final String? errorText;
  final Widget? error;
  const CustomTextField(
      {super.key,
      this.controller,
      this.name,
      this.validator,
      this.errorText,
      this.error,
      this.obscureText = false,
      this.isConPsw = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        style: context.bm,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: name,
          error: error,
          errorText: errorText,
          labelStyle: context.bm,
          errorStyle: context.bm!.copyWith(shadows: [
            const Shadow(
              color: Colors.black,
              offset: Offset(1, 0),
              blurRadius: 0.1,
            ),
          ], color: Colors.red),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
        ),
        validator: validator);
  }
}
