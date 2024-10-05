import 'package:flutter/material.dart';
import 'package:flutter_app_template/feature/weature/weature.dart';
import 'package:go_router/go_router.dart';

class WeatureRouteData extends GoRouteData {
  const WeatureRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WeaturePage();
  }
}
