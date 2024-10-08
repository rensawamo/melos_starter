import 'package:core_di_provider/di_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_color_repository.g.dart';

@riverpod
class ThemeColorRepository extends _$ThemeColorRepository {
  late final SharedPreferences _sharedPreferences;
  final String _themeKey = 'APP_THEME_COLOR_KEY';

  @override
  ThemeMode build() {
    _sharedPreferences = ref.read(sharedPreferencesProvider);
    loadTheme();
    return state;
  }

  Future<void> loadTheme() async {
    final themeIndex =
        _sharedPreferences.getInt(_themeKey) ?? ThemeMode.light.index;
    state = ThemeMode.values[themeIndex];
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    _sharedPreferences.setInt(_themeKey, themeMode.index);
  }
}
