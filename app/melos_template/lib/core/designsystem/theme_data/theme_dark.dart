import 'package:flutter/material.dart';

ThemeData themeDark() {
  const primary = Color.fromARGB(255, 66, 136, 41);
  final base = ThemeData(
    fontFamily: 'Murecho',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: primary,
      primary: primary,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 18),
      headlineMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
    ),
  );

  return base.copyWith(
    scaffoldBackgroundColor: Colors.black,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
