import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chatting/Pages/home_page.dart';
import 'package:real_time_chatting/Pages/login.dart';
import 'package:real_time_chatting/Pages/sign_in_page.dart';
import 'package:real_time_chatting/Pages/sign_up_page.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white),
            ),
            useMaterial3: true,
          ),
          home: const SignUpPage()),
    );
  }
}
