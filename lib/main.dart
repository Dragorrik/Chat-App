import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_type_project/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:task_type_project/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:task_type_project/app/modules/startup_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_type_project/app/modules/theme_controller.dart';
import 'firebase_options.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  Get.put(ThemeController());

  //Get.put(StartupController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: SplashScreenBinding(),
    ),
  );
}
