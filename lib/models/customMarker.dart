class CustomMarker {

  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String description;
  final String? imageUrl;
  final bool visibility; 

  CustomMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.description,
    this.imageUrl,
    this.visibility = true, 
  });

  CustomMarker copyWith({
    String? title,
    String? description,
    bool? visibility,
  }) {
    return CustomMarker(
      id: id,
      latitude: latitude,
      longitude: longitude,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl,
      visibility: visibility ?? this.visibility,
    );
  }

  // 직렬화
  factory CustomMarker.fromJson(Map<String, dynamic> json) {
    return CustomMarker(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      visibility: json['visibility'] ?? true, // JSON에 가시성 정보가 없으면 true로 처리
    );
  }

  // 역직렬화
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'visibility': visibility, // 가시성 속성 추가
    };
  }
}
