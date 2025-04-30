// lib/state/app_state.dart
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {

  // 전역에서 관리하고 추적해야 하는 변수들은 이곳에서 작성되어야 한다.
  // 값의 설정은 직접적으로 수행하지 않고, 전용 메서드를 이용하여 수행한다.
  // 각 상태의 변경 이후엔 notifyListeners를 호출하여 알린다.
  
  // 사용자명
  String _username = '';

  // 사용자명은 외부에서 읽을수만 있음
  String get username => _username;

  // 다크모드 여부
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  // 로그인 여부
  bool get isLoggedIn => _username.isNotEmpty;

  // 상태 변경 함수들
  void setUsername(String name) {
    _username = name;
    notifyListeners(); // 상태 변경 알림
  }

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void logout() {
    _username = '';
    notifyListeners();
  }
}
