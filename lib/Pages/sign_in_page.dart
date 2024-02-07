import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              // controller: controller,
              decoration: InputDecoration(
                labelText: "LL",
                // hintText: "Name",
                disabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorDark),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorDark),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 20),
                ),
                filled: true,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
                child: Text("Sign In"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
