import 'package:basic_app/models/user.dart';
import 'package:basic_app/repositories/mongo_user_repository.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  bool _darkMode = false;
  bool get darkMode => _darkMode;

  bool _markerAddMode = false;
  bool get markerAddMode => _markerAddMode;

  final MongoUserRepository _userRepo = MongoUserRepository(); // Mongo 접근 객체

  void setUser(User user, {String? mode, BuildContext? context}) {
    _user = user;
    notifyListeners();

    if (mode != null && context != null) {
      _userRepo.updateUserInDB(context, user, mode); // context는 굳이 필요 없으면 제거 가능
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void toggleMarkerAddMode() {
    _markerAddMode = !_markerAddMode;
    notifyListeners();
  }

  /// ✅ DB에서 유저 정보 초기화
  Future<void> initializeUser(String id) async {
    final userDoc = await _userRepo.usersCollection.findOne({'id': id});
    if (userDoc != null) {
      _user = User.fromJson(userDoc);
      notifyListeners();
    }
  }
}
