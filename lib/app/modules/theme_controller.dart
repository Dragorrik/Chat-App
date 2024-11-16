import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkTheme = false.obs;

  void toggleTheme(bool value) {
    isDarkTheme.value = value;
    Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
  }
}
