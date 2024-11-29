import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/register_page/controllers/register_page_controller.dart';
import 'package:task_type_project/constants/avatars.dart';

import '../controllers/avatar_page_controller.dart';

class AvatarPageView extends GetView<AvatarPageController> {
  const AvatarPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterPageController registerPageController = Get.find();

    // Screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate dynamic avatar size based on screen width
    final avatarSize =
        screenWidth * 0.25; // Each avatar will be 25% of the screen width
    final gridHeight =
        screenHeight * 0.5; // GridView height is 60% of screen height

    return Scaffold(
      backgroundColor: const Color(0XFF1D1D1D),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your avatar',
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: gridHeight,
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 avatars per row
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: avatars.length - 1,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        registerPageController.profileImageIndex.value = index;
                        controller.isSelected.value =
                            !controller.isSelected.value;
                        print(registerPageController.profileImageIndex.value);
                        if (controller.isSelected.value) {
                          controller.setSelectedAvatar(avatars[index]);
                          _showBottomSheet(controller.selectedAvatar.value);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: controller.isSelected.value &&
                                  index ==
                                      registerPageController
                                          .profileImageIndex.value
                              ? Border.all(
                                  width: 5,
                                  color: Colors.deepPurple,
                                )
                              : Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            avatars[index],
                            height: avatarSize,
                            width: avatarSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(String selectedAvatar) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.30,
        decoration: const BoxDecoration(
          color: Color(0XFF2C2C2C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Selected Avatar Preview
              const Text(
                'Select this Avatar?',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              ClipOval(
                child: Image.asset(
                  selectedAvatar,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      controller.finalizeSelection();
                      Get.snackbar(
                          'Avatar Selected', 'You have selected this avatar!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          colorText: Colors.black);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Get.back();
                      controller.isSelected.value = false;
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}





// Get.bottomSheet(
//                             Container(
//                               height: Get.height * 0.25,
//                               decoration: const BoxDecoration(
//                                 color: Color(0XFF1D1D1D),
//                                 borderRadius: BorderRadius.vertical(
//                                     top: Radius.circular(20)),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       // "Select this" Button
//                                       ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.deepPurple,
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 24, vertical: 12),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(12)),
//                                         ),
//                                         onPressed: () {
//                                           Get.back(); // Close the bottom sheet
//                                           Get.snackbar('Avatar Selected',
//                                               'You selected this avatar!',
//                                               snackPosition:
//                                                   SnackPosition.BOTTOM,
//                                               backgroundColor:
//                                                   Colors.deepPurple,
//                                               colorText: Colors.white);
//                                         },
//                                         child: const Text(
//                                           'Select this',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       // "Cancel" Button
//                                       ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.white,
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 24, vertical: 12),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(12)),
//                                         ),
//                                         onPressed: () {
//                                           Get.back(); // Close the bottom sheet
//                                         },
//                                         child: const Text(
//                                           'Cancel',
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             isScrollControlled: true,
//                           );