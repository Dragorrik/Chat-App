import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Welcome, ${controller.userName}')),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () {
            return Text(
              controller.text.value,
              style: TextStyle(fontSize: 20),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Obx(
          () => AvatarGlow(
            animate: controller.startRecord.value,
            glowColor: Colors.redAccent,
            child: GestureDetector(
              onTapDown: (value) {
                controller.startRecord.value = true;
                controller.recognizedWords();
              },
              onTapUp: (value) {
                controller.startRecord.value = false;
                controller.speechToText.stop();
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                ),
                child: Icon(
                  Icons.mic_none_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
