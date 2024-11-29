import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/chat/controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1D1D1D),
      appBar: AppBar(
        title: Text(
          controller.userName.isEmpty ? "Chat" : controller.userName,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white),
            onPressed: controller.initiateAudioCall,
          ),
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.white),
            onPressed: controller.initiateVideoCall,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Chat Messages
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return Center(
                  child: Text(
                    "No messages yet.",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final messageData = controller.messages[index].data();
                  final isMine =
                      messageData['sender'] == controller.currentUser;

                  return Align(
                    alignment:
                        isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: isMine ? Colors.deepPurple : Colors.white,
                        borderRadius: isMine
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                        border: Border.all(
                          width: 1.5,
                          color: isMine ? Colors.deepPurple : Colors.white,
                        ),
                      ),
                      child: Text(
                        messageData['text'] ?? "",
                        style: TextStyle(
                            fontSize: 16,
                            color: isMine ? Colors.white : Colors.black),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          // Message Input
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 191, 164, 236),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.deepPurple),
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        controller.sendMessage(messageController.text.trim());
                        messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
