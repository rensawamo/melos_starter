import 'package:flutter/material.dart';
import 'package:flutter_app_template/feature/home/home_page.dart';
import 'package:go_router/go_router.dart';

class HomePageData extends GoRouteData {
  const HomePageData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}
