import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_type_project/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:task_type_project/app/modules/register_page/controllers/register_page_controller.dart';
import 'package:task_type_project/app/modules/theme_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final ThemeController themeController = Get.find();
  final LoginPageController loginPageController =
      Get.put(LoginPageController());
  final RegisterPageController registerPageController =
      Get.put(RegisterPageController());
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
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   "Chatitide",
            //   style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            // ),
            Obx(
              () => Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  controller.userName.value.split(' ').first,
                  style: TextStyle(
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                    //fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(),
          ],
        ),
        actions: [
          Obx(
            () => Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search,
                      color: themeController.isDarkTheme.value
                          ? Colors.white
                          : Colors.white),
                  onPressed: () {
                    controller.isSearchActive.value =
                        !controller.isSearchActive.value;
                  },
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt_outlined,
                      color: themeController.isDarkTheme.value
                          ? Colors.white
                          : Colors.white),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    // Capture image from the camera
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      // Save the image to local storage
                      final Directory appDir =
                          await getApplicationDocumentsDirectory();
                      final String savePath =
                          '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
                      await image.saveTo(savePath);

                      // Show confirmation
                      Get.snackbar(
                        "Image Saved",
                        "Your image has been saved to: $savePath",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      // No image captured
                      Get.snackbar(
                        "No Image",
                        "You did not capture any image.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert,
                      color: themeController.isDarkTheme.value
                          ? Colors.white
                          : Colors.white),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Dark Theme'),
                              Obx(
                                () => Switch(
                                  value: themeController.isDarkTheme.value,
                                  onChanged: (value) {
                                    themeController.toggleTheme(value);
                                    Navigator.pop(context); // Close the menu
                                  },
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                loginPageController.signOut();
                              },
                              child: Icon(Icons.logout_outlined)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Stack(
          //   children: [
          //     LoginRegWidget.loginRegBg(), // Your existing background
          //     Positioned.fill(
          //       child: BackdropFilter(
          //         filter: ImageFilter.blur(
          //             sigmaX: 10, sigmaY: 10), // Adjust the blur intensity
          //         child: Container(
          //           color: Colors.black.withOpacity(
          //               0.3), // Optional: add a semi-transparent overlay
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Column(
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
                            prefixIcon:
                                Icon(Icons.search, color: Colors.black54),
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Obx(
              //     () => Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         _buildTab("All", true, context),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         _buildTab("Unread", false, context),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         _buildTab("Groups", false, context),
              //       ],
              //     ),
              //   ),
              // ),

              // Chat list
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: controller
                        .userList.length, // List of all users from Firestore
                    itemBuilder: (context, index) {
                      final user = controller.userList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal,
                        ),
                        title: Container(
                          padding: EdgeInsets.all(7),
                          height: MediaQuery.of(context).size.height * 0.076,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          child: Text(
                            user['userName'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Text(
                          user['email'],
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Get.toNamed('/chat', arguments: {
                            'uid': user['uid'],
                            'userName': user['userName'] ?? "Unknown User",
                            'email': user['email'],
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
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
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.teal,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
      //     BottomNavigationBarItem(icon: Icon(Icons.update), label: "Updates"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.groups), label: "Communities"),
      //     BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
      //   ],
      // ),
    );
  }

  // Helper widget to build each chat item
  Widget _buildChatItem({
    required String avatarUrl,
    required String name,
    // required String message,
    // required String time,
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
      // subtitle: Text(message),
      // trailing: Text(
      //   time,
      //   style: TextStyle(fontSize: 12, color: Colors.grey),
      // ),
    );
  }

  // Helper widget to build a tab
  Widget _buildTab(String text, bool isActive, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.teal[200]
            : themeController.isDarkTheme.value
                ? Colors.grey
                : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
          color:
              themeController.isDarkTheme.value ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
