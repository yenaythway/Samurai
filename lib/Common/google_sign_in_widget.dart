
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';

class GoogleSignInWidget extends ConsumerWidget {
  const GoogleSignInWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.read(loginProvider);
    return InkWell(
      onTap: () async{ 
      UserCredential user = await login.signInWithGoogle();
      
        },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Image.asset(
          "assets/google.png",
          height: 40,
        ),
      ),
    );
  }
}
