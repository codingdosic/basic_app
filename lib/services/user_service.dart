import 'package:basic_app/models/customMarker.dart';
import 'package:basic_app/models/journey.dart';
import 'package:basic_app/models/user.dart';

class UserService {
  /// 마커 추가
  User addMarker(User user, CustomMarker marker) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: [...user.addedMarkers, marker],
      addedJourneys: user.addedJourneys,
    );
  }

  /// 여행기 추가
  User addJourney(User user, Journey journey) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: user.addedMarkers,
      addedJourneys: [...user.addedJourneys, journey],
    );
  }

  /// ✅ 마커 삭제
  User removeMarker(User user, String markerId) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: user.addedMarkers.where((marker) => marker.id != markerId).toList(),
      addedJourneys: user.addedJourneys,
    );
  }

  /// ✅ 마커 수정
  User updateMarker(User user, String markerId, String newTitle, String newSnippet) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: user.addedMarkers.map((marker) {
        if (marker.id == markerId) {
          return CustomMarker(
            id: marker.id,
            latitude: marker.latitude,
            longitude: marker.longitude,
            title: newTitle,
            description: newSnippet,
            imageUrl: marker.imageUrl,
            visibility: marker.visibility,
          );
        }
        return marker;
      }).toList(),
      addedJourneys: user.addedJourneys,
    );
  }

  /// 마커 가시성 토글
  User toggleMarkerVisibility(User user, String markerId) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: user.addedMarkers.map((marker) {
        if (marker.id == markerId) {
          return CustomMarker(
            id: marker.id,
            latitude: marker.latitude,
            longitude: marker.longitude,
            title: marker.title,
            description: marker.description,
            imageUrl: marker.imageUrl,
            visibility: !marker.visibility,
          );
        }
        return marker;
      }).toList(),
      addedJourneys: user.addedJourneys,
    );
  }

  /// 여행기 삭제
  User removeJourney(User user, String journeyId) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: user.addedMarkers,
      addedJourneys: user.addedJourneys.where((journey) => journey.id != journeyId).toList(),
    );
  }

  /// 여행기 수정
  User updateJourney(User user, String journeyId, String newTitle, String newDescription) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: user.addedMarkers,
      addedJourneys: user.addedJourneys.map((journey) {
        if (journey.id == journeyId) {
          return journey.copyWith(title: newTitle, description: newDescription);
        }
        return journey;
      }).toList(),
    );
  }

  /// 여행기 가시성 토글
  User toggleJourneyVisibility(User user, String journeyId) {
    return User(
      id: user.id,
      password: user.password,
      addedMarkers: user.addedMarkers,
      addedJourneys: user.addedJourneys.map((journey) {
        if (journey.id == journeyId) {
          return journey.copyWith(visibility: !journey.visibility);
        }
        return journey;
      }).toList(),
    );
  }
}
