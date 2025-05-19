import 'customMarker.dart'; // Marker 클래스가 별도의 파일에 정의되어 있다고 가정
import 'journey.dart'; // Marker 클래스가 별도의 파일에 정의되어 있다고 가정


class User {
  final String id; // 사용자 ID
  final String password; // 사용자 비밀번호
  final List<CustomMarker> addedMarkers; // 사용자가 추가한 마커 리스트
  final List<Journey> addedJourneys; // 사용자가 추가한 여행기 리스트

  User({
    required this.id,
    required this.password,
    List<CustomMarker>? addedMarkers,
    List<Journey>? addedJourneys,
  })  : addedMarkers = addedMarkers ?? [], // null인 경우 빈 리스트로 초기화
        addedJourneys = addedJourneys ?? [];

  /// JSON 데이터로부터 User 객체 생성
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      password: json['password'],
      addedMarkers: (json['addedMarkers'] as List<dynamic>?)
              ?.map((markerJson) => CustomMarker.fromJson(markerJson))
              .toList() ??
          [],
      addedJourneys: (json['addedJourneys'] as List<dynamic>?)
              ?.map((journeyJson) => Journey.fromJson(journeyJson))
              .toList() ??
          [],
    );
  }

  /// User 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'addedMarkers': addedMarkers.map((marker) => marker.toJson()).toList(),
      'addedJourneys': addedJourneys.map((journey) => journey.toJson()).toList(),
    };
  }

}
