import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Constants/url_const.dart';

final chatProvider =
    ChangeNotifierProvider<ChatProvider>((ref) => ChatProvider());

class ChatProvider extends ChangeNotifier {
  late ChatClient agoraChatClient;
  List msgList = [];
  FocusNode msgFNode = FocusNode();
  TextEditingController msgController = TextEditingController();
  void setupChatClient() async {
    ChatOptions options = ChatOptions(
      appKey: appKey,
      autoLogin: false,
    );
    agoraChatClient = ChatClient.getInstance;
    await agoraChatClient.init(options);
    await ChatClient.getInstance.startCallback();
  }

  void setupListeners() {
    agoraChatClient.addConnectionEventHandler(
      "CONNECTION_HANDLER",
      ConnectionEventHandler(
          onConnected: onConnected,
          onDisconnected: onDisconnected,
          onTokenWillExpire: onTokenWillExpire,
          onTokenDidExpire: onTokenDidExpire),
    );

    agoraChatClient.chatManager.addEventHandler(
      "MESSAGE_HANDLER",
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    );
  }

  void onMessagesReceived(List<ChatMessage> messages) {
    for (var msg in messages) {
      if (msg.body.type == MessageType.TXT) {
        ChatTextMessageBody body = msg.body as ChatTextMessageBody;
        displayMessage(body.content, false);
        debugPrint("Message from ${msg.from}");
      } else {
        String msgType = msg.body.type.name;
        debugPrint("Received $msgType message, from ${msg.from}");
      }
    }
  }

  void onTokenWillExpire() {
    // The token is about to expire. Get a new token
    // from the token server and renew the token.
  }
  void onTokenDidExpire() {
    // The token has expired
  }
  void onDisconnected() {
    // Disconnected from the Chat server
  }
  void onConnected() {
    debugPrint("Connected");
  }

  void sendMessage(String targetId, ChatMessage chatMessage) {
    msgList.insert(0, chatMessage);
    var msg = ChatMessage.createTxtSendMessage(
      targetId: targetId,
      content: msgController.text,
    );

    ChatClient.getInstance.chatManager.sendMessage(msg);
  }

  void joinLeave() async {
    if (!isJoined) {
      // Log in
      try {
        await agoraChatClient.loginWithAgoraToken(userId, token);
        showLog("Logged in successfully as $userId");
        setState(() {
          isJoined = true;
        });
      } on ChatError catch (e) {
        if (e.code == 200) {
          // Already logged in
          setState(() {
            isJoined = true;
          });
        } else {
          showLog("Login failed, code: ${e.code}, desc: ${e.description}");
        }
      }
    } else {
      // Log out
      try {
        await agoraChatClient.logout(true);
        showLog("Logged out successfully");
        setState(() {
          isJoined = false;
        });
      } on ChatError catch (e) {
        showLog("Logout failed, code: ${e.code}, desc: ${e.description}");
      }
    }
  }
}
