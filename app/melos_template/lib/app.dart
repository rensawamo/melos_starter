import 'package:core_repository/theme_color/theme_color_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/designsystem/theme_data/theme_dark.dart';
import 'package:flutter_app_template/core/designsystem/theme_data/theme_light.dart';
import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeColorRepositoryProvider);
    // final textScale = ref.watch(themeTextRepositoryProvider);
    return MaterialApp.router(
      title: 'melos template',
      theme: themeLight(),
      darkTheme: themeDark(),
      themeMode: themeMode,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
