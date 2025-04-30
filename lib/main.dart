// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/app_state.dart';
import 'app/app.dart';

void main() {
  runApp(
    
    // provider 설정
    ChangeNotifierProvider( 
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}
