import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/get_started_screen_controller.dart';

class GetStartedScreenView extends GetView<GetStartedScreenController> {
  const GetStartedScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 219, 219),
      body: SafeArea(
        child: Container(
          //padding: const EdgeInsets.all(15),
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/com.png'),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Get.offNamed('/login');
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
