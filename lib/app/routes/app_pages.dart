import 'package:get/get.dart';

import '../modules/avatar_page/bindings/avatar_page_binding.dart';
import '../modules/avatar_page/views/avatar_page_view.dart';
import '../modules/call/bindings/call_binding.dart';
import '../modules/call/views/call_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/get_started_screen/bindings/get_started_screen_binding.dart';
import '../modules/get_started_screen/views/get_started_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/startup_binding.dart';
import '../modules/startup_screen.dart';

//import 'package:flutter/material.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

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
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED_SCREEN,
      page: () => GetStartedScreenView(),
      binding: GetStartedScreenBinding(),
    ),
    GetPage(
      name: _Paths.AVATAR_PAGE,
      page: () => const AvatarPageView(),
      binding: AvatarPageBinding(),
    ),
    GetPage(
      name: _Paths.CALL,
      page: () => const CallView(),
      binding: CallBinding(),
    ),
  ];
}
