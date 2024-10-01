// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// part 'theme_color_repository.g.dart';

// @riverpod
// class ThemeColorRepository extends _$ThemeColorRepository {
//   late final SharedPreferences _preferences;
//   final String _themeKey;

//   @override
//   ThemeMode build() {
//     _preferences = ref.read(prefsRepositoryProvider);
//     loadTheme();
//     return state;
//   }

//   Future<void> loadTheme() async {
//     final themeIndex =
//         _prefsRepository.fetch<int>(_themeKey) ?? ThemeMode.light.index;
//     state = ThemeMode.values[themeIndex];
//   }

//   Future<void> setTheme(ThemeMode themeMode) async {
//     state = themeMode;
//     await _prefsRepository.save<int>(_themeKey, themeMode.index);
//   }
// }
