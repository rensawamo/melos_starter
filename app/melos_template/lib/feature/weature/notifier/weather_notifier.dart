import 'package:core_repository/repository.dart';
import 'package:core_utility/utility/app_logger.dart';
import 'package:melos_template/feature/weature/model/weature_state.dart';
import 'package:melos_template/feature/weature/repository/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_notifier.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  Future<WeatherState> _fetchWeatherData(String city) async {
    final repository = await ref.read(weatherRepositoryProvider.future);
    final notification = await ref.watch(notificationTokenProvider.future);
    logger.d('notification: ${notification.fcmToken}');
    logger.d('notification: ${notification.apnsToken}');
    return repository.getWeather(city);
  }

  @override
  Future<WeatherState> build(String city) async {
    return _fetchWeatherData(city);
  }
}
