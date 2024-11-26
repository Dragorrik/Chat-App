import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/login_page/controllers/login_page_controller.dart';
import '../controllers/home_controller.dart';
import 'package:task_type_project/app/modules/theme_controller.dart';

class HomeView extends GetView<HomeController> {
  //final ThemeController themeController = Get.find();
  final LoginPageController _loginPageController =
      Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1D1D1D),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0XFF1D1D1D),
          child: Column(
            children: [
              // Profile and Settings
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: ClipOval(
                          child: controller.userImage.value.isNotEmpty
                              ? Image.file(
                                  File(controller.userImage.value),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.userName.value,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        controller.userEmail.value,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text("Settings", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Navigate to settings
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.white),
                title: Text("Profile", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Navigate to profile
                },
              ),
              Spacer(), // Pushes the logout to the bottom
              Divider(color: Colors.grey), // Adds a divider above logout
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout", style: TextStyle(color: Colors.red)),
                onTap: () {
                  _loginPageController.signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.userList.isEmpty) {
            return Center(
              child: Text(
                "No users available.",
                style: TextStyle(color: Colors.deepPurple, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.userList.length,
            itemBuilder: (context, index) {
              final user = controller.userList[index];
              //final profileImage = user['profileImage'];

              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: controller.getProfileImage(user['uid']) != null
                        ? Image.file(
                            File(controller.getProfileImage(user['uid'])!),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/default_profile.jpg',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  // backgroundImage: profileImage != null
                  //     ? FileImage(File(profileImage))
                  //     : AssetImage('assets/images/default_avatar.png')
                  //         as ImageProvider,
                ),
                title: Text(
                  user['userName'] ?? "Unknown User",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  user['email'] ?? "No Email",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  Get.toNamed('/chat', arguments: {
                    'uid': user['uid'],
                    'userName': user['userName'],
                    'email': user['email'],
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
