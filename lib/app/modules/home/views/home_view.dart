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
      body: Obx(() {
        return controller.voiceList.isEmpty
            ? Center(
                child: Text(
                  "Nothing to show",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: controller.voiceList.length,
                itemBuilder: (context, index) {
                  final voice = controller.voiceList[index];
                  return ListTile(
                    title: Text(voice),
                  );
                },
              );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Obx(
          () => AvatarGlow(
            animate: controller.startRecord.value,
            glowColor: Colors.redAccent,
            child: GestureDetector(
              onTapDown: (value) {
                controller.startRecording();
              },
              onTapUp: (value) {
                controller.stopRecording();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.1,
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
