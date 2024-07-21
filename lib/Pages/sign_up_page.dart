import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Common/google_sign_in_widget.dart';
import 'package:real_time_chatting/Pages/name_page.dart';
import 'package:real_time_chatting/Pages/sign_in_page.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';
import 'package:real_time_chatting/Utils/extension.dart';
import 'package:real_time_chatting/Utils/super_scaffold.dart';
import 'package:real_time_chatting/Widgets/custom_buttom.dart';
import 'package:real_time_chatting/Widgets/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/login.png",
                ))),
        child: const SuperScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.read(loginProvider);
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (context, ref, child) {
                final mailError = ref.watch(loginProvider).mailError;
                return CustomTextField(
                  labelText: "Gmail",
                  controller: login.emailController,
                  errorText: mailError,
                  validator: (value) => login.validateEmail(value),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final pswError = ref.watch(loginProvider).pswError;
                return CustomTextField(
                  labelText: "Passowrd",
                  obscureText: true,
                  errorText: pswError,
                  controller: login.pswController,
                  validator: (value) => login.validatePassword(value),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final confError = ref.watch(loginProvider).confError;
                return CustomTextField(
                  labelText: "Confirm Passowrd",
                  obscureText: true,
                  errorText: confError,
                  controller: login.confpswController,
                  validator: (value) => login.validateConfPassword(value),
                );
              },
            ),
            CustomTextButton(
              text: 'Sign Up',
              ontap: () async {
                if (formKey.currentState!.validate()) {
                  if (await login.signUp()) {
                    if (!context.mounted) return;
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const NamePage()),
                      // (Route<dynamic> route) => false
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: context.bs!.copyWith(color: Colors.white),
                ),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage())),
                  child: Text("Sign In",
                      style: context.bs!.copyWith(color: Colors.blue)),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
            const GoogleSignInWidget()
          ],
        ),
      ),
    );
  }
}
