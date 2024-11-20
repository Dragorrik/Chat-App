import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/chat/controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  //final ChatPageController controller = Get.put(ChatPageController());

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${controller.chatUser}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index].data();
                  final isMine = message['sender'] == controller.currentUser;
                  return Align(
                    alignment:
                        isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: isMine ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(
                            color: isMine ? Colors.white : Colors.black),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    controller.sendMessage(messageController.text);
                    messageController.clear();
                    //messageController.dispose();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
