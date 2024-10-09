import 'package:core_di_provider/di_provider.dart';
import 'package:core_repository/theme_color/theme_color_repository.dart';
import 'package:core_test_util/fake/fake_shard_preferences.dart';
import 'package:core_test_util/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  late ProviderContainer container;
  late FakeSharedPreferences fakeSharedPreferences;
  const themeKey = 'APP_THEME_COLOR_KEY';

  setUp(() {
    fakeSharedPreferences = FakeSharedPreferences();
    container = createContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(fakeSharedPreferences),
      ],
    );
  });
  group('ThemeColorRepository', () {
    test('loadTheme should load the theme from FakeSharedPreferences',
        () async {
      // Arrange
      await fakeSharedPreferences.setInt(
        themeKey,
        ThemeMode.dark.index,
      );
      // Act
      final themeColorRepository = container.read(themeColorRepositoryProvider);

      // Assert
      expect(themeColorRepository, ThemeMode.dark);
    });

    test('setTheme should save the theme to FakeSharedPreferences', () async {
      // Arrange
      final themeColorRepository =
          container.read(themeColorRepositoryProvider.notifier);
      await themeColorRepository.setTheme(ThemeMode.dark);
      // Act
      final loadedTheme = fakeSharedPreferences.getInt(themeKey);
      // Assert
      expect(loadedTheme, ThemeMode.dark.index);
    });
  });
}
