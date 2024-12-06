import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/home/controllers/home_controller.dart';
import 'package:task_type_project/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:task_type_project/constants/avatars.dart';

class ProfileDrawer extends GetView<HomeController> {
  final LoginPageController _loginPageController =
      Get.put(LoginPageController());
  ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0XFF1D1D1D),
      child: Obx(
        () => Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: Get.height * 0.1,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0XFF1D1D1D),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                ],
              ),
            ),
            // Profile Fields
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        CircleAvatar(
                          radius: 40,
                          child: ClipOval(
                            child: Image.asset(
                              avatars[controller.userImageIndex.value],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.userName.value,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.userOccupation.value,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ProfileField(
                      label: 'Your Email',
                      value: controller.userEmail.value,
                      icon: Icons.email_outlined,
                    ),
                    ProfileField(
                      label: 'Phone Number',
                      value: controller.userPhoneNo.value,
                      icon: Icons.phone_outlined,
                    ),
                    ProfileField(
                      label: 'Password',
                      value: '**********',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    InkWell(
                      onTap: () {
                        _loginPageController.signOut();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 78, 66),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sign out",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.logout),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isPassword;

  const ProfileField({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0XFFF7F6F9),
            borderRadius: BorderRadius.circular(12),
            //border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: isPassword ? Colors.black54 : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
