// lib/app/routes.dart
import 'package:flutter/material.dart';

import '../features/login/login_page.dart';
import '../features/home/home_page.dart';
import '../features/settings/settings_page.dart';

final Map<String, WidgetBuilder> appRoutes = {

  // 앱 실행 시 첫 화면
  '/': (context) => const LoginPage(),

  // 로그인 이후 메인 화면
  '/home': (context) => const HomePage(),

  // 설정 페이지
  '/settings': (context) => const SettingsPage(),
};
