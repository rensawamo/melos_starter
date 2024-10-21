import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/foundation.dart';
import 'package:dio/dio.dart';
import 'package:melos_template/core/network/api_client/weather_api_client.dart';
import 'package:melos_template/feature/weature/weature_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weature_viewmodel.g.dart';

@riverpod
class WeatherViewmodel extends _$WeatherViewmodel {
  @override
  WeatherState build() {
    return const WeatherState(
      weatherData: null,
    );
  }

  Future<bool> hasInternetConnection() async {
    final connectivity = ref.read(connectivityProvider);
    final result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  Future<AppError?> call() async {
    state = state.copyWith(isLoading: true);

    final client = ref.read(weatherApiClientProvider);
    //  Replace this with your own API key from https://openweathermap.org/api and create Environment file
    const apiKey = 'cc95d932d5a45d33a9527d5019475f2c';

    try {
      final data = await client.getCurrentWeather('Tokyo', apiKey);
      state = state.copyWith(
        isLoading: false,
        weatherData: data,
      );
      return null;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (e is DioException) {
        return AppError.dioException(e);
      } else {
        return AppError.unknownError(e.toString());
      }
    }
  }
}
