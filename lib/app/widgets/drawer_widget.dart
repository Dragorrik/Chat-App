import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/home/controllers/home_controller.dart';
import 'package:task_type_project/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:task_type_project/constants/avatars.dart';

class ProfileDrawer extends GetView<HomeController> {
  final LoginPageController _loginPageController =
      Get.put(LoginPageController());

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _occupationController = TextEditingController();

  ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.7,
      backgroundColor: const Color(0XFF1D1D1D),
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
                  IconButton(
                    onPressed: () {
                      _showEditProfileDialog(context);
                    },
                    icon: Icon(Icons.settings, color: Colors.white),
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20),
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
                      Spacer(),
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
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    _usernameController.text = controller.userName.value;
    _passwordController.text = '';
    _occupationController.text = controller.userOccupation.value;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0XFF1D1D1D),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _occupationController,
                decoration: InputDecoration(
                  labelText: 'Occupation',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () async {
                // Display a loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                try {
                  // Update username, password, and occupation
                  String newUsername = _usernameController.text.trim();
                  String newPassword = _passwordController.text.trim();
                  String newOccupation = _occupationController.text.trim();

                  if (newUsername.isNotEmpty) {
                    await controller.updateUsername(newUsername);
                  }

                  if (newPassword.isNotEmpty) {
                    await controller.updateUserPassword(newPassword);
                  }

                  if (newOccupation.isNotEmpty) {
                    await controller.updateUserOccupation(newOccupation);
                  }

                  // Close all dialogs and notify the user
                  Navigator.of(context).pop(); // Close the loading indicator
                  Navigator.of(context).pop(); // Close the profile edit dialog
                  Get.snackbar('Success', 'Profile updated successfully');
                } catch (e) {
                  // Handle errors and close the loading indicator
                  Navigator.of(context).pop(); // Close the loading indicator
                  Get.snackbar('Error', 'Failed to update profile: $e');
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
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
