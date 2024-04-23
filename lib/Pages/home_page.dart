import 'package:flutter/material.dart';
import 'package:real_time_chatting/Pages/all_users_page.dart';
import 'package:real_time_chatting/Utils/extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.notifications, color: Colors.white),
            SizedBox(
              width: 10,
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 55, 0, 255),
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: Text(
            "Chats",
            style: context.bl,
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 55, 0, 255),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: const AllUserWidget(),
          ),
        ),
      ),
    );
  }
}
