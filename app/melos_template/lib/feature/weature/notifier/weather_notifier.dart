import 'package:melos_template/feature/weature/model/weature_state.dart';
import 'package:melos_template/feature/weature/repository/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_notifier.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  late final WeatherRepository repository;

  @override
  Future<WeatherState> build(String city) async {
    repository = await ref.read(weatherRepositoryProvider.future);
    return _initState(city);
  }

  Future<WeatherState> _initState(String city) async {
    return repository.getWeather(city);
  }

  Future<void> updateState(String city) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return repository.getWeather(city);
    });
  }
}
