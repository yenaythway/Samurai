import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_time_chatting/Utils/global_util.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalUtil.navigatorKey,
        theme: ThemeData(
          primaryColor: Colors.black,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.amber),
          ),
          useMaterial3: true,
        ),
        home: const SignUpPage());
  }
}
