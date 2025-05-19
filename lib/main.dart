// lib/main.dart
import 'package:basic_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/app_state.dart';
import 'app/app.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); // 비동기 코드 실행 보장
  await DatabaseService.connectDB("mongodb+srv://admin:admin@practice.esvba.mongodb.net/?retryWrites=true&w=majority&appName=Practice", "users"); // DB 연결 후 앱 실행

  runApp(
    
    // provider 설정
    ChangeNotifierProvider( 
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}
