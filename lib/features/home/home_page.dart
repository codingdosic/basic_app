import 'package:basic_app/maps/maps_widget.dart';
import 'package:basic_app/models/customMarker.dart';
import 'package:basic_app/models/user.dart';
import 'package:basic_app/repositories/mongo_user_repository.dart';
import 'package:basic_app/services/user_service.dart';
import 'package:basic_app/widgets/common/expandable_button.dart';
import 'package:basic_app/widgets/dialogs/userContentBottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../widgets/base_scaffold.dart';
import '../../widgets/common/info_card.dart';
import '../../widgets/common/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? _googleMapController;

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().user;

    return BaseScaffold(
      title: '홈',
      currentIndex: 0,
      body: Stack(
        children: [
          MapsWidget(onMapCreated: _onMapCreated), // 수정: 컨트롤러 콜백 전달

          Positioned(
            bottom: 20,
            right: 20,
            child: ExpandableButton(
              onBtn1: () {
                context.read<AppState>().toggleMarkerAddMode();
              },
              onBtn2: () {},
              onBtn3: () {
                if (_googleMapController != null && user != null) {
                  showUserContentBottomSheet(context, user, _googleMapController!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
