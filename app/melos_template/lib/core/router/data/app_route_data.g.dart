// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $introductionRouteData,
      $homePageData,
    ];

RouteBase get $introductionRouteData => GoRouteData.$route(
      path: '/introduction',
      factory: $IntroductionRouteDataExtension._fromState,
    );

extension $IntroductionRouteDataExtension on IntroductionRouteData {
  static IntroductionRouteData _fromState(GoRouterState state) =>
      const IntroductionRouteData();

  String get location => GoRouteData.$location(
        '/introduction',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homePageData => GoRouteData.$route(
      path: '/home',
      factory: $HomePageDataExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'setting',
          factory: $SettingPageDataExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'weature',
          factory: $WeatureRouteDataExtension._fromState,
        ),
      ],
    );

extension $HomePageDataExtension on HomePageData {
  static HomePageData _fromState(GoRouterState state) => const HomePageData();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingPageDataExtension on SettingPageData {
  static SettingPageData _fromState(GoRouterState state) =>
      const SettingPageData();

  String get location => GoRouteData.$location(
        '/home/setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WeatureRouteDataExtension on WeatureRouteData {
  static WeatureRouteData _fromState(GoRouterState state) =>
      const WeatureRouteData();

  String get location => GoRouteData.$location(
        '/home/weature',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
