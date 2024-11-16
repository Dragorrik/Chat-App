import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_type_project/app/modules/theme_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   //final LoginPageController loginPageController = Get.find();
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Obx(() => Text('Welcome, ${controller.userName}')),
  //       centerTitle: true,
  //       actions: [
  //         IconButton(
  //           onPressed: () {
  //             LoginPageController().signOut();
  //           },
  //           icon: Icon(Icons.logout_rounded),
  //         ),
  //       ],
  //     ),
  //     body: Obx(() {
  //       return controller.voiceList.isEmpty
  //           ? Center(
  //               child: Text(
  //                 "Nothing to show",
  //                 style: TextStyle(fontSize: 20),
  //               ),
  //             )
  //           : ListView.builder(
  //               itemCount: controller.voiceList.length,
  //               itemBuilder: (context, index) {
  //                 final voice = controller.voiceList[index];
  //                 return ListTile(
  //                   title: Text(voice),
  //                 );
  //               },
  //             );
  //     }),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //     floatingActionButton: Padding(
  //       padding: EdgeInsets.only(bottom: 50),
  //       child: Obx(
  //         () => AvatarGlow(
  //           animate: controller.startRecord.value,
  //           glowColor: Colors.redAccent,
  //           child: GestureDetector(
  //             onTapDown: (value) {
  //               controller.startRecording();
  //             },
  //             onTapUp: (value) {
  //               controller.stopRecording();
  //             },
  //             child: Container(
  //               height: MediaQuery.of(context).size.height * 0.1,
  //               width: MediaQuery.of(context).size.height * 0.1,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Colors.redAccent,
  //               ),
  //               child: Icon(
  //                 Icons.mic_none_rounded,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //What'sApp UI Clone
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "SomeApp",
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black54),
            onPressed: () {
              controller.isSearchActive.value =
                  !controller.isSearchActive.value;
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: Colors.black54),
          //   onPressed: () {},
          // ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.black54),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark Theme'),
                    Obx(() => Switch(
                          value: ThemeController().isDarkTheme.value,
                          onChanged: (value) {
                            ThemeController().toggleTheme(value);
                            Navigator.pop(context); // Close the menu
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Obx(
            () => controller.isSearchActive.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search, color: Colors.black54),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ),
          // Tab bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTab("All", true, context),
                SizedBox(
                  width: 10,
                ),
                _buildTab("Unread", false, context),
                SizedBox(
                  width: 10,
                ),
                _buildTab("Groups", false, context),
              ],
            ),
          ),

          // Chat list
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with dynamic data length
              itemBuilder: (context, index) {
                return _buildChatItem(
                  avatarUrl:
                      "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png",
                  name: "Contact ${index + 1}",
                  message: "Last message preview here...",
                  time: "9:15 AM",
                );
              },
            ),
          ),
        ],
      ),

      // Floating Action Button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.teal,
      //   child: Icon(Icons.message, color: Colors.white),
      // ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: "Updates"),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups), label: "Communities"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        ],
      ),
    );
  }

  // Helper widget to build each chat item
  Widget _buildChatItem({
    required String avatarUrl,
    required String name,
    required String message,
    required String time,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
        radius: 25,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(message),
      trailing: Text(
        time,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  // Helper widget to build a tab
  Widget _buildTab(String text, bool isActive, BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.03,
      // width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.teal[200] : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }
}
