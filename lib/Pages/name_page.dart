import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_time_chatting/Pages/sign_in_page.dart';
import 'package:real_time_chatting/Utils/extension.dart';
import 'package:real_time_chatting/Utils/super_scaffold.dart';
import 'package:real_time_chatting/Widgets/custom_buttom.dart';
import 'package:real_time_chatting/Widgets/custom_text_form_field.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

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
        child: SuperScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextField(
                  labelText: "Name",
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
                const SizedBox(
                  height: 20,
                ),
                CustomTextButton(
                  text: "Next",
                  ontap: () async {
                    if (!context.mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SignInPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
