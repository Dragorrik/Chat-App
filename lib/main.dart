import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_type_project/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_type_project/app/modules/user_data/user.dart';
import 'firebase_options.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter()); // Register the adapter
  await Hive.openBox<UserData>('users'); // Open the box for user data

  // Open the necessary Hive boxes
  await Hive.openBox('userBox');
  await Hive.openBox('profileImageBox');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  //Get.put(ThemeController());
  //Get.put(HomeController());
  //Get.put(StartupController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
          color: Colors.white,
        )),
      ),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.system,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: SplashScreenBinding(),
    ),
  );
}
