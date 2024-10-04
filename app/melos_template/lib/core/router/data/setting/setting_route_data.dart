import 'package:flutter/material.dart';
import 'package:flutter_app_template/feature/setting/setting_page.dart';
import 'package:go_router/go_router.dart';

class SettingPageData extends GoRouteData {
  const SettingPageData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingPage();
  }
}
