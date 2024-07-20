import 'package:flutter/material.dart';
import 'package:real_time_chatting/Constants/colors.dart';
import 'package:real_time_chatting/Pages/all_users_page.dart';
import 'package:real_time_chatting/Pages/chat_page.dart';
import 'package:real_time_chatting/Utils/extension.dart';
import 'package:real_time_chatting/Widgets/container_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            InkWell(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChatPage())),
                child: const Icon(
                  Icons.messenger,
                  color: Colors.white,
                )),
            // const SizedBox(
            //   width: 10,
            // ),
            // const Icon(Icons.notifications, color: Colors.white),
            const SizedBox(
              width: 10,
            ),
          ],
          backgroundColor: primaryColor,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: Text(
            "Home",
            style: context.bl,
          ),
        ),
        body: const ContainerBody(child: AllUserWidget()),
      ),
    );
  }
}
