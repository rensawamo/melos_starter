import 'package:core_foundation/foundation.dart';
import 'package:core_network/rest/dio/dio_provider.dart';
import 'package:flutter_app_template/core/network/api_client/weather_api_client.dart';
import 'package:flutter_app_template/feature/weature/weature_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weature_viewmodel.g.dart';

@riverpod
class WeatherViewmodel extends _$WeatherViewmodel {
  @override
  WeatherState build() {
    return const WeatherState(
      isLoading: true,
      weatherData: null,
    );
  }

  Future<AppError?> fetchWeather() async {
    final dio = ref.read(dioProvider);
    final client = WeatherApiClient(dio);
    const apiKey = 'cc95d932d5a45d33a9527d5019475f2c';

    try {
      final data = await client.getCurrentWeather('Tokyo', apiKey);
      logger.d('Weather data: $data');
      state = state.copyWith(
        isLoading: false,
        weatherData: data,
      );
      return null;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (e is AppError) {
        return e;
      } else {
        return AppError.unknownError(e.toString());
      }
    }
  }
}
