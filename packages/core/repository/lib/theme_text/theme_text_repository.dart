import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_text_repository.g.dart';

@riverpod
class ThemeTextRepository extends _$ThemeTextRepository {
  late final SharedPreferences _sharedPreferences;
  late final String _scaleKey;

  @override
  AppTextScale build() {
    _sharedPreferences = ref.read(sharedPreferencesProvider);
    loadScale();
    return state;
  }

  Future<AppTextScale> loadScale() async {
    final scaleIndex =
        await _sharedPreferences.getInt(_scaleKey) ?? AppTextScale.normal.index;
    state = AppTextScale.values[scaleIndex];
    return state;
  }

  Future<void> setScale(AppTextScale scale) async {
    state = scale;
    await _sharedPreferences.setInt(_scaleKey, scale.index);
  }
}
