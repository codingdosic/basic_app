// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import '../state/app_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // provider로 앱 상태 구독 
    final appState = context.watch<AppState>(); 

    return MaterialApp(

      // 디버그 라벨 제거
      debugShowCheckedModeBanner: false,

      // 스위처 제목
      title: 'Testing App',

      // 테마 설정(다크모드, 주요 버튼 색상)
      theme: ThemeData(
        brightness: appState.darkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
      ),

      // 시작 라우트
      initialRoute: '/',

      // 라우팅 테이블
      routes: appRoutes,
      
    );
  }
}
