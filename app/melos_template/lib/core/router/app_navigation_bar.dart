import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// bottom navigation bar 管理クラス
/// [navigationShell] によって、画面遷移を管理する
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: navigationShell,
          bottomNavigationBar: Stack(
            children: [
              NavigationBar(
                selectedIndex: navigationShell.currentIndex,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: 'setting',
                  ),
                ],
                onDestinationSelected: (index) {
                  navigationShell.goBranch(
                    index,
                    initialLocation: index == navigationShell.currentIndex,
                  );
                },
                // selectedItemColor: Colors.blue,
                indicatorColor: Colors.blue,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              ),
              // Divider
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.3,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
