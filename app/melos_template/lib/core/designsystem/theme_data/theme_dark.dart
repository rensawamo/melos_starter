import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeDark() {
  const primary = Color.fromARGB(255, 56, 106, 31);
  final base = ThemeData(
    fontFamily: GoogleFonts.kiwiMaru().fontFamily,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      
      brightness: Brightness.dark,
      
      
      seedColor: primary,
    
    
      primary: primary,
      surface: primary,
 
      error: Colors.blue,
 
      surfaceContainerLow: Colors.grey,
    ),

    textTheme: const TextTheme(
    
      bodyMedium: TextStyle(fontSize: 18),
    
      headlineMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
    ),
  );

  return base.copyWith(
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
    ),

    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),

    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
