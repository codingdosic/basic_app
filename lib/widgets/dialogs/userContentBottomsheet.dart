import 'package:basic_app/models/customMarker.dart';
import 'package:basic_app/services/user_service.dart';
import 'package:basic_app/state/app_state.dart';
import 'package:basic_app/widgets/dialogs/edit_item_dialog.dart';
import 'package:basic_app/widgets/dialogs/user_content_card.dart';
import 'package:flutter/material.dart';
import 'package:basic_app/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void showUserContentBottomSheet(BuildContext context, User user, GoogleMapController mapController) {
  bool showMarkers = true;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    // isDismissible: false, // 외부 터치로 닫히지 않게
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          

          final appState = context.read<AppState>();
          final user = appState.user!;
          final userService = UserService();

          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        showMarkers ? '📍 저장된 마커' : '📓 저장된 여행기',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.swap_horiz),
                        tooltip: '전환',
                        onPressed: () {
                          setState(() {
                            showMarkers = !showMarkers;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: showMarkers ? user.addedMarkers.length : user.addedJourneys.length,
                    itemBuilder: (context, index) {
                      if (showMarkers) {
                        final marker = user.addedMarkers[index];
                        LatLng position = LatLng(marker.latitude, marker.longitude);
                        return MarkerCard(
                          
                          marker: marker,
                          onToggleVisibility: () {
                            setState(() {
                              appState.setUser(
                                userService.toggleMarkerVisibility(user, marker.id),
                                mode: "marker",
                                context: context,
                              );
                            });
                          },
                          onEdit: () async {

                            final result = await showDialog(
                              context: context,
                              builder: (context) => EditItemDialog(
                                mode: 'marker',
                                isNew: true,
                                position: position,
                                initialTitle: marker.title,
                                initialDescription: marker.description,
                              ),
                            );

                            if (result != null && result['title'] != null) {
                              appState.setUser(
                                userService.updateMarker(user, marker.id, result['title'], result['snippet']),
                                mode: "marker",
                                context: context,
                              );
                            } 
                          },
                          onDelete: () {
                            appState.setUser(
                                userService.removeMarker(user, marker.id),
                                mode: "marker",
                                context: context,
                            );
                          },
                          onTap: () async {
                            final screenPoint = await mapController.getScreenCoordinate(
                              LatLng(marker.latitude, marker.longitude),
                            );

                            // y값을 위로 150px 정도 보정
                            final adjustedPoint = ScreenCoordinate(
                              x: screenPoint.x,
                              y: screenPoint.y +170, // 보정값 조절 가능
                            );

                            final adjustedLatLng = await mapController.getLatLng(adjustedPoint);

                            await mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(adjustedLatLng, 14.0),
                            );
                          },

                        );
                      } else {
                        final journey = user.addedJourneys[index];
                        return JourneyCard(
                          journey: journey,
                          onEdit: () {
                            // TODO: 수정 다이얼로그 호출
                          },
                          onDelete: () {
                            setState(() {
                              user.addedJourneys.removeAt(index);
                            });
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
