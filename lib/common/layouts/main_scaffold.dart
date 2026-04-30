import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/navigation/app_bottom_nav_bar.dart';
import 'package:pedal/features/map/viewmodels/map_viewmodel.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  void _onTabTapped(BuildContext context, int index) {
    // map 탭(2)에서 다른 탭으로 이동 시 네비게이션 상태 초기화
    if (navigationShell.currentIndex == 2 && index != 2) {
      context.read<MapViewModel>().clearNavigationState();
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
