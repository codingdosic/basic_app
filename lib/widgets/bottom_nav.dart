import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {

  // 현재 선택된 탭 인덱스
  final int currentIndex;

  // 생성자
  const BottomNav({
    super.key, 
    required this.currentIndex
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      currentIndex: currentIndex,

      // 각 아이콘 클릭 시 이동할 화면 
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/settings');
        }
      },

      // 내비게이션 바 아이콘
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
