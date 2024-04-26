import 'package:flutter/material.dart';
import 'package:real_time_chatting/Constants/colors.dart';
import 'package:real_time_chatting/Utils/extension.dart';
import 'package:real_time_chatting/Widgets/back_arrow.dart';
import 'package:real_time_chatting/Widgets/container_body.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: const BackArrowButton(),
          title: Text(
            "Chats",
            style: context.bl,
          ),
        ),
        body: const ContainerBody(
          child: Text(" "),
        ),
      ),
    );
  }
}
