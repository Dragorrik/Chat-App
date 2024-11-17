//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/register_page/views/register_page_view.dart';
import 'package:task_type_project/app/modules/startup_binding.dart';
import 'package:task_type_project/app/modules/startup_screen.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.STARTUP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.STARTUP,
      page: () => StartupScreen(), // Empty page as the controller will redirect
      binding: StartupBinding(), // Attach StartupBinding
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
  ];
}
