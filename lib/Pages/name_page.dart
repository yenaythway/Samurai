import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Pages/home_page.dart';
import 'package:real_time_chatting/Pages/sign_in_page.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';
import 'package:real_time_chatting/Utils/extension.dart';
import 'package:real_time_chatting/Utils/super_scaffold.dart';
import 'package:real_time_chatting/Widgets/custom_buttom.dart';
import 'package:real_time_chatting/Widgets/custom_text_form_field.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(context) {
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
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                )),
            backgroundColor: Colors.black,
          ),
          body: const NameForm(),
        ),
      ),
    );
  }
}

class NameForm extends ConsumerWidget {
  const NameForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.read(loginProvider);
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Expanded(flex: 3, child: SizedBox.shrink()),
            Consumer(
              builder: (context, ref, child) {
                final nameError = ref.watch(loginProvider).nameError;
                return CustomTextField(
                  labelText: "Name",
                  errorText: nameError,
                  controller: login.nameController,
                  validator: (value) => login.validateName(value),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.amber,
                ),
                Text(
                  "Warning : ",
                  style: context.bs,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This name will be shown to the public.",
                      style: context.bs,
                    ),
                    Text(
                      "Don't enter sensitive info.",
                      style: context.bs,
                    )
                  ],
                ),
              ],
            ),
            const Expanded(flex: 2, child: SizedBox.shrink()),
            CustomTextButton(
              text: "Next",
              ontap: () async {
                if (formKey.currentState!.validate()) {
                  if (await login.createAccountToAgora()) {
                    login.clearAfterSignUp();
                    if (!context.mounted) return;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                        (Route<dynamic> route) => false);
                  }
                }
              },
            ),
            const Expanded(flex: 4, child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
