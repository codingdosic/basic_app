import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../models/user.dart';
import '../services/database_service.dart';
import '../state/app_state.dart';
import 'package:provider/provider.dart';

// 
class MongoUserRepository {

  final mongo.DbCollection usersCollection = DatabaseService.collection('users');

  Future<bool> loginUser(BuildContext context, String id, String password) async {
    
    var userData = await usersCollection.findOne(mongo.where.eq('id', id));

    if (userData != null && userData['password'] == password) {
      User loggedInUser = User.fromJson(userData);

      // ✅ Provider(GlobalUser)를 사용하여 현재 사용자 설정
      Provider.of<AppState>(context, listen: false).setUser(loggedInUser);

      print("✅ 로그인 성공: ${loggedInUser.id}");
      return true;
    } else {
      print("❌ 로그인 실패: ID 또는 비밀번호 오류");
      return false;
    }
  }

  Future<bool> userExists(String id) async {
    var user = await usersCollection.findOne(mongo.where.eq('id', id));
    return user != null;
  }

  Future<void> addUserIfNotExists(BuildContext context, String id, String password) async {

    bool exists = await userExists(id); // 사용자 존재여부 

    if (exists) { // 이미 존재할 경우
      print("⚠️ 이미 존재하는 사용자: $id");
      return;
    }

    // 새로운 사용자 객체 생성
    User newUser = User(id: id, password: password);

    // MongoDB에 저장
    await usersCollection.insertOne(newUser.toJson()); // json 형태로 추가
    print("✅ 새 사용자 추가 완료: $id");

    // ✅ Provider(GlobalUser)를 사용하여 현재 사용자 설정
    Provider.of<AppState>(context, listen: false).setUser(newUser);
  }

  Future<void> handleLogin(BuildContext context, String id, String password) async {

    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("아이디와 비밀번호를 입력하세요!"))
      );
      return;
    }

    // ✅ MongoDB에 사용자 추가 (없을 때만)
    await addUserIfNotExists(context, id, password);

    // ✅ 사용자 로그인 처리 추가
    bool loginSuccess = await loginUser(context, id, password);

    if (!loginSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 실패. ID 또는 비밀번호를 확인하세요."))
      );
      return;
    }

    // ✅ 로그인 성공 시 provider의 AppState에 user 정보 초기화
    final appState = Provider.of<AppState>(context, listen: false);
    await appState.initializeUser(id);
    
  }

  Future<void> updateUserInDB(BuildContext context, User user, String mode) async {
    if(mode == "marker"){
      await usersCollection.updateOne( // 조건에 맞는 사용자 정보 업데이트
        mongo.where.eq('id', user.id), // 주어진 id 속성에 맞는 도큐먼트 검색
        mongo.modify.set('addedMarkers', user.addedMarkers.map((m) => m.toJson()).toList()), // 검색한 도큐먼트의 속성을 변경된 user의 것으로 교체
      );
    }
    else if(mode == "journey"){
      await usersCollection.updateOne( // 조건에 맞는 사용자 정보 업데이트
        mongo.where.eq('id', user.id), // 주어진 id 속성에 맞는 도큐먼트 검색
        mongo.modify.set('addedJourneys', user.addedJourneys.map((m) => m.toJson()).toList()), // 검색한 도큐먼트의 속성을 변경된 user의 것으로 교체
      );
    }
    print("✅ 사용자 정보 업데이트 완료: ${user.id}");
  }
}
