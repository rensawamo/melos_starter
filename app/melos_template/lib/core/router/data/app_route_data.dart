import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:melos_template/core/router/app_navigation_bar.dart';
import 'package:melos_template/core/router/data/home/home_route_data.dart';
import 'package:melos_template/core/router/data/setting/setting_route_data.dart';
import 'package:melos_template/core/router/data/weature/weature_route_data.dart';
import 'package:melos_template/core/router/observer/transition_observer.dart';
import 'package:melos_template/core/router/routes.dart';
import 'package:melos_template/feature/introduction/introduction_page.dart';

part 'app_route_data.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final firstNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'first');
final secoundNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'secound');

@TypedGoRoute<IntroductionRouteData>(
  path: Routes.introduction,
  routes: <TypedGoRoute<GoRouteData>>[],
)
class IntroductionRouteData extends GoRouteData {
  const IntroductionRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const IntroductionPage();
  }
}

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    /// bottom tab1
    TypedStatefulShellBranch<FirstBranch>(
      routes: [
        TypedGoRoute<HomePageData>(
          path: Routes.home,
          routes: [
            TypedGoRoute<WeatureRouteData>(path: Routes.weature),
          ],
        ),
      ],
    ),

    /// bottom tab2
    TypedStatefulShellBranch<SecoundBranch>(
      routes: [
        TypedGoRoute<SettingPageData>(path: Routes.setting),
      ],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();
  static final GlobalKey<NavigatorState> $navigatorKey = firstNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppNavigationBar(
      navigationShell: navigationShell,
    );
  }
}

/// bottom tab1 branch
class FirstBranch extends StatefulShellBranchData {
  const FirstBranch();

  static final List<NavigatorObserver> $observers = [
    TransitionObserver(),
  ];
  static final GlobalKey<NavigatorState> $navigatorKey = firstNavigatorKey;
}

/// bottom tab2 branch
class SecoundBranch extends StatefulShellBranchData {
  const SecoundBranch();

  static final List<NavigatorObserver> $observers = [
    TransitionObserver(),
  ];
  static final GlobalKey<NavigatorState> $navigatorKey = secoundNavigatorKey;
}
