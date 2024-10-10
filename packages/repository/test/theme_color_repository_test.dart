import 'package:core_di_provider/di_provider.dart';
import 'package:core_repository/theme_color/theme_color_repository.dart';
import 'package:core_test_util/test_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  late ProviderContainer container;
  late FakeSharedPreferences fakeSharedPreferences;
  late ThemeColorRepository themeColorRepository;
  const themeKey = 'APP_THEME_COLOR_KEY';

  setUp(() {
    fakeSharedPreferences = FakeSharedPreferences();
    container = createContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(fakeSharedPreferences),
      ],
    );
    themeColorRepository =
        container.read(themeColorRepositoryProvider.notifier);
  });
  group('ThemeColorRepository', () {
    test('loadTheme should load the theme from SharedPreferences', () async {
      // Arrange
      await fakeSharedPreferences.setInt(
        themeKey,
        ThemeMode.dark.index,
      );
      // Act
      await themeColorRepository.loadTheme();

      // Assert
      final theme = container.read(themeColorRepositoryProvider);
      expect(theme, ThemeMode.dark);
    });

    test('loadTheme should load the default theme when nothing is saved',
        () async {
      // Act
      await themeColorRepository.loadTheme();

      // Assert
      final theme = container.read(themeColorRepositoryProvider);
      expect(theme, ThemeMode.light);
    });

    test('setTheme should save the theme to SharedPreferences', () async {
      // Arrange
      await themeColorRepository.setTheme(ThemeMode.dark);
      // Act
      final loadedTheme = fakeSharedPreferences.getInt(themeKey);
      // Assert
      expect(loadedTheme, ThemeMode.dark.index);
    });
  });
}
