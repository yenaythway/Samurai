import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chatting/Pages/name_page.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';
import 'package:real_time_chatting/Utils/super_scaffold.dart';
import 'package:real_time_chatting/Widgets/custom_buttom.dart';
import 'package:real_time_chatting/Widgets/custom_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
          body: SignUpForm(loginProvider: loginProvider),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
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
          children: <Widget>[
            Selector<LoginProvider, String>(
              selector: (context, _) => _.mailError,
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
              selector: (context, _) => _.pswError,
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
            Selector<LoginProvider, String>(
              selector: (context, _) => _.confError,
              builder: (context, e, _) {
                return CustomTextField(
                  labelText: "Confirm Passowrd",
                  obscureText: true,
                  errorText: e,
                  controller: loginProvider.confpswController,
                  validator: (value) =>
                      loginProvider.validateConfPassword(value),
                );
              },
            ),
            CustomTextButton(
              text: 'Sign Up',
              ontap: () async {
                // if (formKey.currentState!.validate()) {
                //   if (await loginProvider.signUp()) {
                //     loginProvider.clearAfterSignUp();
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const NamePage(),
                  ),
                );
                //   }
                // }
              },
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
