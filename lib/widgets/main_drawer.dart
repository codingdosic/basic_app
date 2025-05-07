import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class MainDrawer extends StatelessWidget {

  const MainDrawer({
    super.key
  });

  @override
  Widget build(BuildContext context) {

    // provider 변수 설정
    final username = context.watch<AppState>().username;

    return Drawer(

      child: ListView(

        // 사용자 정보 헤더
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: Text('$username@example.com'),
          ),

          // 내부 아이템
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              context.read<AppState>().logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
