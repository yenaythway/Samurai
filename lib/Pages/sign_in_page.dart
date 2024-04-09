import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';
import 'package:real_time_chatting/Utils/super_scaffold.dart';
import 'package:real_time_chatting/Widgets/custom_text_form_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

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
          body: SignInForm(loginProvider: loginProvider),
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.loginProvider,
  });

  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<LoginProvider, String>(
              selector: (context, loginProvider) => loginProvider.mailError,
              builder: (context, e, _) {
                return CustomTextField(
                  labelText: "Gmail",
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
                  labelText: "Passowrd",
                  obscureText: true,
                  errorText: e,
                  controller: loginProvider.pswController,
                  validator: (value) => loginProvider.validatePassword(value),
                );
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
                child: const Text("Sign In"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
