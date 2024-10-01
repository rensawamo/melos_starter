import 'package:core_foundation/emun/app_prefs_key.dart';
import 'package:core_foundation/foundation.dart';
import 'package:core_repository/shared_preferences/shared_preference_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_text_repository.g.dart';

@riverpod
class ThemeTextRepository extends _$ThemeTextRepository {
  late final SharedPreferencesRepository _prefsRepository;
  final AppPrefsKey _scaleKey = AppPrefsKey.configFontScale;

  @override
  AppTextScale build() {
    _prefsRepository = ref.read(sharedPreferencesRepositoryProvider);
    loadScale();
    return state;
  }

  Future<AppTextScale> loadScale() async {
    final scaleIndex =
        _prefsRepository.fetch<int>(_scaleKey) ?? AppTextScale.normal.index;
    state = AppTextScale.values[scaleIndex];
    return state;
  }

  Future<void> setScale(AppTextScale scale) async {
    state = scale;
    await _prefsRepository.save<int>(_scaleKey, scale.index);
  }
}


