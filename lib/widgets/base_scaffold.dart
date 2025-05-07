import 'package:flutter/material.dart';
import 'main_drawer.dart';
import 'bottom_nav.dart';

class BaseScaffold extends StatelessWidget {

  // 앱바에 표시될 제목
  final String title;

  // 화면의 메인 콘텐츠
  final Widget body;

  // 현재 활성화된 화면의 인덱스(바텀 내비게이션)
  final int currentIndex;

  // 생성자
  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 앱바
      appBar: AppBar(title: Text(title)),

      // 드로어 메뉴(scaffold에 설정 시 앱바에 자동으로 버튼 생성됨)
      drawer: const MainDrawer(),

      body: body,

      bottomNavigationBar: BottomNav(currentIndex: currentIndex),
    );
  }
}
