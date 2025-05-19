import 'package:mongo_dart/mongo_dart.dart' as mongo;

// db와의 통신 로직 구현
class DatabaseService {

  static late mongo.Db db; // db 변수

  /// ✅ MongoDB 연결 함수 (앱 시작 시 1회 실행)
  static Future<void> connectDB(String connectionString, String collectionName) async {

    db = await mongo.Db.create( // 커넥션 스트링으로 연결
      connectionString
    );

    await db.open(); // db 연결

    print("✅ MongoDB Atlas 연결 성공!"); // 연결 성공 시 출력

  }

  static mongo.DbCollection collection(String name) => db.collection(name);
}
