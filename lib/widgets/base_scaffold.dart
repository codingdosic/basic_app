import 'package:flutter/material.dart';
import 'main_drawer.dart';
import 'bottom_nav.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;

  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const MainDrawer(),
      body: body,
      bottomNavigationBar: BottomNav(currentIndex: currentIndex),
    );
  }
}
