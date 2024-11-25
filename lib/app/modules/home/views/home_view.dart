import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:task_type_project/app/modules/theme_controller.dart';

class HomeView extends GetView<HomeController> {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1D1D1D),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.userName.value.split(' ').first,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Get.offAllNamed('/login');
            },
          ),
        ],
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
                  Get.offAllNamed('/chat', arguments: {
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
