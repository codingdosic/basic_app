import 'package:basic_app/models/customMarker.dart';
import 'package:basic_app/services/user_service.dart';
import 'package:basic_app/state/app_state.dart';
import 'package:basic_app/widgets/dialogs/edit_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsController{
  // 맵 탭 핸들러
  Future<void> onMapTapped(LatLng position, BuildContext context) async {
    final markerAddMode = context.read<AppState>().markerAddMode;
  
    if (!markerAddMode) return;
  
    final result = await showDialog(
      context: context,
      builder: (context) => EditItemDialog(
        mode: 'marker',
        isNew: true,
        position: position,
      ),
    );

    if (result != null && result['title'] != null) {
      final appState = context.read<AppState>();
      final user = appState.user!;
      final userService = UserService();

      // 예시: 마커 모델에 맞게 생성
      final newMarker = CustomMarker(
        id: UniqueKey().toString(),
        title: result['title'],
        description: result['snippet'],
        latitude: position.latitude,
        longitude: position.longitude,
        visibility: true,
        imageUrl: result['image'], // 선택한 이미지가 있다면
      );
      appState.setUser(
        userService.addMarker(user, newMarker),
        mode: "marker",
        context: context,
      );
    } 
  } 
}
