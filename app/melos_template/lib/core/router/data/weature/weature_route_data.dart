import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melos_template/feature/weature/weature.dart';

class WeatureRouteData extends GoRouteData {
  const WeatureRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WeaturePage();
  }
}
