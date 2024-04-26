import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Constants/colors.dart';
import 'package:real_time_chatting/Providers/chat_provider.dart';
import 'package:real_time_chatting/Utils/extension.dart';
import 'package:real_time_chatting/Widgets/back_arrow.dart';
import 'package:real_time_chatting/Widgets/container_body.dart';

class ConversationPage extends ConsumerWidget {
  const ConversationPage({super.key});

  @override
  Widget build(context, ref) {
    final chat = ref.read(chatProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackArrowButton(),
          title: Text(
            "Name",
            style: context.bl,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.videocam,
                  color: Colors.white,
                ))
          ],
          backgroundColor: primaryColor,
        ),
        body: ContainerBody(
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => chat.msgFNode.unfocus(),
                  child: ListView.builder(
                    reverse: true,
                    itemBuilder: (_, index) {
                      final chatMsg = chat.msgList[index].chatMessage;
                      return GestureDetector(
                        child: Align(
                          alignment: chatMsg.direction == MessageDirection.SEND
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 8,
                                right:
                                    chatMsg.direction == MessageDirection.SEND
                                        ? 0
                                        : 80,
                                left: chatMsg.direction ==
                                        MessageDirection.RECEIVE
                                    ? 0
                                    : 80),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: chatMsg.direction == MessageDirection.SEND
                                  ? Colors.blue[200]
                                  : Colors.grey.shade200,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  chatMsg.direction == MessageDirection.SEND
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                chatMsg.direction == MessageDirection.SEND
                                    ? const SizedBox()
                                    : Text(
                                        chatMsg.from ?? "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue),
                                        textAlign: chatMsg.direction ==
                                                MessageDirection.SEND
                                            ? TextAlign.end
                                            : TextAlign.start,
                                      ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: chat.msgList.length,
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    border: Border(top: BorderSide(color: primaryColor))),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.mic,
                        color: primaryColor.withOpacity(0.5),
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: chat.msgFNode,
                        controller: chat.msgController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                            hintStyle:
                                context.bl!.copyWith(color: Colors.black)),
                        style: context.bl!.copyWith(color: Colors.black),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          chat.sendMessage(targetId, chatMessage)
                        },
                        icon: Icon(Icons.send,
                            color: primaryColor.withOpacity(0.5)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
