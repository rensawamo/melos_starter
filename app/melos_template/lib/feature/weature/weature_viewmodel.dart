import 'package:core_foundation/foundation.dart';
import 'package:core_network/network.dart';
import 'package:flutter_app_template/core/model/weater/weater_data/weather_data.dart';
import 'package:flutter_app_template/feature/weature/weature_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weature_viewmodel.g.dart';

// Urlsクラス
class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475fd2c';

  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';

  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}

@riverpod
class WeatureViewmodel extends _$WeatureViewmodel {
  @override
  WeatherState build() {
    return const WeatherState(
      isLoading: true,
      weatherData: null,
    );
  }

  Future<AppError?> fetchWeather() async {
    final dioClient = ref.read(dioClientProvider);

    try {
      final response = await dioClient.get(
        Urls.currentWeatherByName('Tokyo'),
      );
      final weatherData =
          WeatherData.fromJson(response as Map<String, dynamic>);
      state = state.copyWith(
        isLoading: false,
        weatherData: weatherData,
      );
    } catch (e) {
      logger.e('Failed to fetch weather data: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch weather data: $e',
      );
      if (e is AppError) {
        logger.e('AppError: $e');
        return e;
      } else {
        return AppError.unknownError(
          'Failed to fetch weather data: $e',
        );
      }
    }
    return null;
  }
}
