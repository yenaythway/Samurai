import 'dart:async';
import 'dart:io';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';
// import 'package:camera_camera/camera_camera.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart';
// import 'package:my_care_client_v2/controller/sdkchat_controller.dart';
// import 'package:my_care_client_v2/widget/super_print.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import '../constant/const_url.dart';
// import '../utils/notification_service.dart';
// import 'agora_call_page.dart';

class AgoraChatSdkPage extends StatefulWidget {
  final String userId;
  final String conversationId;
  final String videoChannel;
  const AgoraChatSdkPage(
      {super.key,
      required this.userId,
      required this.conversationId,
      required this.videoChannel});

  @override
  State<AgoraChatSdkPage> createState() => _AgoraChatSdkPageState();
}

// class ChatSdkModel {
//   final ChatMessage chatMessage;
//   final String previewImgPath;

//   ChatSdkModel({required this.chatMessage, required this.previewImgPath});
// }

class _AgoraChatSdkPageState extends State<AgoraChatSdkPage> {
  // SdkChatContorller sdkChatContorller = Get.put(SdkChatContorller());
  final List<String> _logText = [];
  List _showChatList = [];
  final FocusNode _focusNode = FocusNode();

  TextEditingController msgController = TextEditingController();
  String imgPath = "";
  String filePath = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // _clearData();
    // _initSDK();
    // _addChatListener();
  }

  @override
  void dispose() {
    ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
    ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversationId),
        actions: [
          IconButton(
              onPressed: () {
                // Get.to(AgoraCallPage(
                //   channelName: widget.videoChannel,
                // ));
              },
              icon: const Icon(Icons.videocam))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: _showChatList.isEmpty && isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      reverse: true,
                      itemBuilder: (_, index) {
                        final chatMsg = _showChatList[index].chatMessage;
                        return GestureDetector(
                          // onTap: _handleTap,
                          // onLongPress: chatMsg.body.type == MessageType.IMAGE ||
                          //         chatMsg.body.type == MessageType.FILE
                          //     ? () {
                          //         showDialog(
                          //             context: context,
                          //             builder: (BuildContext context) {
                          //               return AlertDialog(
                          //                 title: const Text(
                          //                     'Download'), // To display the title it is optional
                          //                 content: const Text(
                          //                     'Are you sure want to download ?'), // Message which will be pop up on the screen
                          //                 // Action widget which will provide the user to acknowledge the choice
                          //                 actions: [
                          //                   TextButton(
                          //                     onPressed: () {
                          //                       Get.back();
                          //                     }, // function used to perform after pressing the button
                          //                     child: const Text('CANCEL'),
                          //                   ),
                          //                   TextButton(
                          //                     onPressed: () {
                          //                       if (chatMsg.body.type ==
                          //                           MessageType.IMAGE) {
                          //                         ChatImageMessageBody msgBody =
                          //                             chatMsg.body
                          //                                 as ChatImageMessageBody;
                          //                         Get.back();
                          //                         _downloadFile(
                          //                             webUrl:
                          //                                 msgBody.remotePath!);
                          //                       } else if (chatMsg.body.type ==
                          //                           MessageType.FILE) {
                          //                         ChatFileMessageBody msgBody =
                          //                             chatMsg.body
                          //                                 as ChatFileMessageBody;
                          //                         Get.back();
                          //                         _downloadFile(
                          //                             webUrl:
                          //                                 msgBody.remotePath!);
                          //                       }
                          //                     },
                          //                     child: const Text('OK'),
                          //                   ),
                          //                 ],
                          //               );
                          //             });
                          //       }
                          //     : null,
                          child: Align(
                            alignment:
                                chatMsg.direction == MessageDirection.SEND
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
                                color:
                                    chatMsg.direction == MessageDirection.SEND
                                        ? Colors.blue[200]
                                        : Colors.grey.shade200,
                              ),
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
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
                                  //     SizedBox(width: 4,),
                                  const SizedBox(height: 8),
                                  // _showMsgItem(_showChatList[
                                  //     index]), //text or image file
                                  // const SizedBox(height: 6),
                                  // Text(time,
                                  //     style: TextStyle(
                                  //         fontSize: 12, color: Colors.grey))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: _showChatList.length,
                    ),
            ),
            // chosenImage(),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () {
                    setState(() {
                      // previewList = [];
                    });
                    // _settingModalBottomSheet(context);
                  },
                ),
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: msgController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter message",
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // _sendMessage();
                      // _sendImageMessage();
                      // _sendFileMessage();
                      // sdkChatContorller.isImageFetched.value = false;
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget chosenImage() {
  //   return Obx(() {
  //     if (sdkChatContorller.isImageFetched.value && imgPath.isNotEmpty) {
  //       return Container(
  //         decoration: BoxDecoration(
  //           color: Colors.grey[100], //blue[100],
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Colors.black,
  //               spreadRadius: -5, // Controls the spread of the shadow
  //               blurRadius: 5, // Controls the blur effect of the shadow
  //               offset: Offset(0, 1),
  //             )
  //           ],
  //         ),
  //         padding:
  //             const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
  //         child: Row(
  //           children: [
  //             Container(
  //               decoration:
  //                   BoxDecoration(borderRadius: BorderRadius.circular(50)),
  //               height: 70,
  //               child: Image.file(
  //                 File(imgPath),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             const Expanded(
  //                 child: Center(
  //                     child: Text(
  //               "Chosen photo ",
  //               style: TextStyle(color: Colors.black54),
  //             ))),
  //             GestureDetector(
  //               onTap: () {
  //                 imgPath = "";
  //                 sdkChatContorller.isImageFetched.value = false;
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   boxShadow: const [
  //                     BoxShadow(
  //                       color: Colors.black,
  //                       spreadRadius: -5, // Controls the spread of the shadow
  //                       blurRadius: 5, // Controls the blur effect of the shadow
  //                       offset: Offset(0, 3),
  //                     )
  //                   ],
  //                   borderRadius: BorderRadius.circular(50),
  //                 ),
  //                 height: 30,
  //                 width: 30,
  //                 child: const Center(
  //                   child: Icon(
  //                     Icons.close,
  //                     size: 20,
  //                   ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     } else {
  //       return const SizedBox();
  //     }
  //   });
  // }

  // void _handleTap() {
  //   // Hide the keyboard when the chat conversation is tapped
  //   _focusNode.unfocus();
  // }

  // Future<void> _downloadFile({required String webUrl}) async {
  //   try {
  //     bool launched =
  //         await launchUrlString(webUrl, mode: LaunchMode.externalApplication);

  //     if (!launched) {
  //       launchUrlString(webUrl);
  //     }
  //   } catch (e) {
  //     throw 'Could not open the website.';
  //   }
  // }

  // _showMsgItem(ChatSdkModel chatSdkModel) {
  //   switch (chatSdkModel.chatMessage.body.type) {
  //     case MessageType.TXT:
  //       {
  //         ChatTextMessageBody msgBody =
  //             chatSdkModel.chatMessage.body as ChatTextMessageBody;
  //         return Text(
  //           msgBody.content,
  //         );
  //       }
  //     case MessageType.IMAGE:
  //       {
  //         return Image.file(
  //           File(chatSdkModel.previewImgPath),
  //           fit: BoxFit.cover,
  //           height: 150,
  //           width: 150,
  //         );
  //       }
  //     case MessageType.VIDEO:
  //       {}
  //       break;
  //     case MessageType.LOCATION:
  //       {}
  //       break;
  //     case MessageType.VOICE:
  //       {}
  //       break;
  //     case MessageType.FILE:
  //       {
  //         ChatFileMessageBody msgBody =
  //             chatSdkModel.chatMessage.body as ChatFileMessageBody;
  //         String img = "";
  //         if (msgBody.displayName!.contains(".pdf")) {
  //           img = "assets/images/pdf.png";
  //         } else if (msgBody.displayName!.contains(".pptx")) {
  //           img = "assets/images/pptx.png";
  //         } else if (msgBody.displayName!.contains("docx")) {
  //           img = "assets/images/word.png";
  //         }
  //         return Column(
  //           children: [
  //             Stack(
  //               children: [
  //                 img.isNotEmpty
  //                     ? Image.asset(
  //                         img,
  //                         width: 80,
  //                         height: 80,
  //                         fit: BoxFit.cover,
  //                       )
  //                     : const SizedBox(),
  //               ],
  //             ),
  //             Text(msgBody.displayName!)
  //           ],
  //         );
  //       }
  //     case MessageType.CUSTOM:
  //       {}
  //       break;
  //     case MessageType.CMD:
  //       {
  //         // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
  //       }

  //       break;
  //     case MessageType.COMBINE:
  //       {
  //         // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
  //       }

  //       break;
  //   }
  //   return const SizedBox();
  // }

  // _clearData() {
  //   setState(() {
  //     isLoading = true;
  //     _showChatList = [];
  //     _logText.clear();
  //     imgPath = "";
  //     filePath = "";
  //   });
  // }

  // _retrieveMessage() async {
  //   try {
  //     _clearData();
  //     ChatCursorResult<ChatMessage> list =
  //         await ChatClient.getInstance.chatManager.fetchHistoryMessages(
  //             conversationId: widget.conversationId, pageSize: 10);
  //     for (int i = 0; i < list.data.length; i++) {
  //       ChatMessage element = list.data[i];

  //       if (element.body.type == MessageType.IMAGE) {
  //         await _imageMessage(element);
  //       } else {
  //         _addLogToConsole(chatMessage: element);
  //       }
  //     }
  //     setState(() {
  //       isLoading = false;
  //     });
  //     EasyLoading.dismiss();
  //   } on ChatError catch (e) {
  //     superPrint(e);
  //     EasyLoading.dismiss();
  //   }
  // }

  // _imageMessage(ChatMessage element) async {
  //   ChatImageMessageBody msgBody = element.body as ChatImageMessageBody;
  //   var response = await get(Uri.parse(msgBody.remotePath!)); // <--2
  //   var documentDirectory = await getApplicationDocumentsDirectory();

  //   var firstPath =
  //       "${documentDirectory.path}/images${_showChatList.length + 1}";
  //   var filePathAndName =
  //       '${documentDirectory.path}/images${_showChatList.length + 1}.jpg';
  //   //comment out the next three lines to prevent the image from being saved
  //   //to the device to show that it's coming from the internet
  //   await Directory(firstPath).create(recursive: true); // <-- 1
  //   File file2 = File(filePathAndName); // <-- 2
  //   file2.writeAsBytesSync(response.bodyBytes); // <-- 3
  //   _addLogToConsole(chatMessage: element, imgPath: filePathAndName);
  // }

  // void _initSDK() async {
  //   ChatOptions options = ChatOptions(
  //     appKey: appKey,
  //     autoLogin: false,
  //   );
  //   await ChatClient.getInstance.init(options);
  //   await ChatClient.getInstance.startCallback();
  //   // _deleteConversationWithId();
  //   _signIn();

  //   // _retrieveMessage();
  // }

  // void _signIn() async {
  //   try {
  //     _clearData();
  //     await ChatClient.getInstance.login(
  //       widget.userId,
  //       widget.userId, //"09797314034"
  //     );
  //     _retrieveMessage();
  //   } on ChatError catch (e) {
  //     if (e.code == 104) {
  //       EasyLoading.showToast(e.description,
  //           duration: const Duration(seconds: 1));
  //     } else {
  //       _signOut();
  //     }
  //     EasyLoading.dismiss();
  //   }
  // }

  // void _signOut() async {
  //   try {
  //     await ChatClient.getInstance.logout(true);
  //     _signIn();
  //     // _addLogToConsole(msg: "sign out succeed");
  //   } on ChatError catch (e) {
  //     // _addLogToConsole(
  //     //     msg: "sign out failed, code: ${e.code}, desc: ${e.description}");
  //     EasyLoading.showToast(e.description,
  //         duration: const Duration(seconds: 1));
  //   }
  // }

  // void _sendMessage() async {
  //   if (widget.conversationId.isEmpty || msgController.text.isEmpty) {
  //     // _addLogToConsole(msg: "single chat id or message content is null");
  //     return;
  //   }

  //   var msg = ChatMessage.createTxtSendMessage(
  //     targetId: widget.conversationId,
  //     content: msgController.text,
  //   );

  //   ChatClient.getInstance.chatManager.sendMessage(msg);
  //   setState(() {
  //     msgController.text = "";
  //   });
  // }

  // void _sendImageMessage() async {
  //   if (widget.conversationId.isEmpty || imgPath.isEmpty) {
  //     // _addLogToConsole(msg: "single chat id or message content is null");
  //     return;
  //   }

  //   var msg = ChatMessage.createImageSendMessage(
  //       targetId: widget.conversationId, filePath: imgPath);

  //   ChatClient.getInstance.chatManager.sendMessage(msg);

  //   setState(() {
  //     imgPath = "";
  //   });
  // }

  // void _sendFileMessage() async {
  //   if (widget.conversationId.isEmpty || filePath.isEmpty) {
  //     // _addLogToConsole(msg: "single chat id or message content is null");
  //     return;
  //   }
  //   var msg = ChatMessage.createFileSendMessage(
  //       targetId: widget.conversationId, filePath: filePath);

  //   ChatClient.getInstance.chatManager.sendMessage(msg);

  //   setState(() {
  //     filePath = "";
  //   });
  // }

  // Future getMultipleImage() async {
  //   FilePickerResult? files = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );
  //   if (files != null) {
  //     setState(() {
  //       imgPath = files.files.first.path!;
  //       sdkChatContorller.isImageFetched.value = true;
  //     });
  //   }
  // }

  // Future getFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   //  File file = File(result.files.single.path);
  //   // List<File> files = result.paths.map((path) => File(path)).toList();
  //   if (result != null) {
  //     setState(() {
  //       filePath = result.files.first.path!;
  //     });
  //   }
  // }

  // void _settingModalBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Wrap(
  //           children: <Widget>[
  //             ListTile(
  //                 leading: const Icon(Icons.file_copy_sharp),
  //                 title: const Text('File '),
  //                 onTap: () {
  //                   Get.back();
  //                   getFile();
  //                 }),
  //             ListTile(
  //                 leading: const Icon(Icons.photo),
  //                 title: const Text('Gallery '),
  //                 onTap: () {
  //                   Get.back();
  //                   getMultipleImage();
  //                 }),
  //             ListTile(
  //               leading: const Icon(Icons.camera),
  //               title: const Text('Take Photo'),
  //               onTap: () async {
  //                 Get.back();
  //                 Get.to(CameraCamera(
  //                   onFile: (file) async {
  //                     // if (file != null) {
  //                     setState(() {
  //                       imgPath = file.path;
  //                     });
  //                     // }
  //                     Get.back();
  //                   },
  //                 ));
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  // void _addLogToConsole(
  //     {required ChatMessage chatMessage, String imgPath = ""}) async {
  //   // _logText.add(_timeString + ": " + log);
  //   // final df = new DateFormat('yyyy-MM-dd hh:mm');
  //   // String time = df.format(
  //   //     DateTime.fromMillisecondsSinceEpoch(
  //   //         chatMsg.serverTime * 1000));
  //   setState(() {
  //     _showChatList.insert(
  //         0, ChatSdkModel(chatMessage: chatMessage, previewImgPath: imgPath));
  //   });
  //   // _scrollDown();
  // }

  // void _addChatListener() {
  //   // Adds message status changed event.
  //   ChatClient.getInstance.chatManager.addMessageEvent(
  //       "UNIQUE_HANDLER_ID",
  //       ChatMessageEvent(
  //         onSuccess: (msgId, msg) async {
  //           if (msg.body.type == MessageType.IMAGE) {
  //             await _imageMessage(msg);
  //           } else {
  //             _addLogToConsole(chatMessage: msg);
  //           }
  //         },
  //         onProgress: (msgId, progress) {
  //           // _addLogToConsole(msg: "send message succeed");
  //         },
  //         onError: (msgId, msg, error) {
  //           EasyLoading.showToast(error.description,
  //               duration: const Duration(seconds: 1));
  //         },
  //       ));
  //   // Adds receive new messages event.
  //   ChatClient.getInstance.chatManager.addEventHandler(
  //     "UNIQUE_HANDLER_ID",
  //     ChatEventHandler(onMessagesReceived: onMessagesReceived),
  //   );
  // }

  // void onMessagesReceived(List<ChatMessage> messages) async {
  //   for (var msg in messages) {
  //     switch (msg.body.type) {
  //       case MessageType.TXT:
  //         {
  //           ChatTextMessageBody body = msg.body as ChatTextMessageBody;
  //           if (widget.conversationId == msg.from) {
  //             _addLogToConsole(chatMessage: msg);
  //           }

  //           NotificationService().showNotificationWithPayload(
  //               id: _showChatList.length + 1,
  //               title: msg.from!,
  //               body: body.content,
  //               payload: body.content);
  //         }
  //         break;
  //       case MessageType.IMAGE:
  //         {
  //           await _imageMessage(msg);
  //           NotificationService().showNotificationWithPayload(
  //               id: _showChatList.length + 1,
  //               title: msg.from!,
  //               body: "sent a image",
  //               payload: "sent a image");
  //         }
  //         break;
  //       case MessageType.VIDEO:
  //         {}
  //         break;
  //       case MessageType.LOCATION:
  //         {}
  //         break;
  //       case MessageType.VOICE:
  //         {}
  //         break;
  //       case MessageType.FILE:
  //         {
  //           _addLogToConsole(chatMessage: msg);
  //           NotificationService().showNotificationWithPayload(
  //               id: _showChatList.length + 1,
  //               title: msg.from!,
  //               body: "sent a file",
  //               payload: "sent a file");
  //         }
  //         break;
  //       case MessageType.CUSTOM:
  //         {}
  //         break;
  //       case MessageType.CMD:
  //         {
  //           // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
  //         }
  //         break;
  //       case MessageType.COMBINE:
  //         {
  //           // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
  //         }

  //         break;
  //     }
  //   }
  // }
}
