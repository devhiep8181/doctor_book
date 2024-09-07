import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_theme/app_colors.dart';
import '../utils/text_constants.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grey400Color,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: TextConstant.homeLabel),
          BottomNavigationBarItem(
              icon: const Icon(Icons.event),
              label: TextConstant.scheduleLabel),
          BottomNavigationBarItem(
              icon: const Icon(Icons.chat),
              label: TextConstant.chatLabel),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: TextConstant.accountLabel)
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
