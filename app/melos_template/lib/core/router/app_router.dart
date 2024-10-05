import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/data/app_route_data.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.home,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorWidget(
        Exception('Route for ${state.uri} not found'),
      ),
    ),
    redirect: (context, state) {
      return null;
    },
  );
});
