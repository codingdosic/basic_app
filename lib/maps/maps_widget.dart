import 'package:basic_app/maps/maps_controller.dart';
import 'package:basic_app/models/user.dart';
import 'package:basic_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsWidget extends StatefulWidget {
  final void Function(GoogleMapController)? onMapCreated;

  const MapsWidget({super.key, this.onMapCreated});

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}


class _MapsWidgetState extends State<MapsWidget> {

  late final MapsController mapsController = MapsController();
  GoogleMapController? _mapController;

  // 초기 위치 (예: 서울)
  static const LatLng _initialPosition = LatLng(37.5665, 126.9780);
  static const double _initialZoom = 12.0;

  // 마커 탭 핸들러
  void _onMarkerTapped(MarkerId markerId) {
    print("📍 Marker tapped: ${markerId.value}");
    // 필요 시 bottom sheet 등 호출 가능
  }

  // 맵 탭 핸들러
  void _onMapTapped(LatLng position) {
    print("🗺️ Map tapped: $position");
    // 필요 시 마커 추가 로직 등 가능
    mapsController.onMapTapped(position, context);
  }

  // 마커 렌더링
  Set<Marker> _buildMarkers(User user) {
    return user.addedMarkers.map((m) {
      final markerId = MarkerId(m.id);
      return Marker(
        markerId: markerId,
        position: LatLng(m.latitude, m.longitude),
        infoWindow: InfoWindow(title: m.title, snippet: m.description),
        visible: m.visibility,
        onTap: () => _onMarkerTapped(markerId),
      );
    }).toSet();
  }

  // // 폴리라인 생성 (마커 순서대로 연결)
  // Set<Polyline> _buildPolylines(User user) {
  //   final points = user.addedMarkers
  //       .where((m) => m.visibility)
  //       .map((m) => LatLng(m.latitude, m.longitude))
  //       .toList();

  //   return {
  //     Polyline(
  //       polylineId: const PolylineId('route'),
  //       color: Colors.blue,
  //       width: 4,
  //       points: points,
  //     )
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().user!;
    
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: _initialPosition,
        zoom: _initialZoom,
      ),
      onMapCreated: (controller) {
        _mapController = controller;
        if (widget.onMapCreated != null) {
          widget.onMapCreated!(controller);
        }
      },
      onTap: _onMapTapped,
      markers: _buildMarkers(user),
      // polylines: _buildPolylines(user),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
    );
  }
}
