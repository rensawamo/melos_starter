import 'package:flutter_app_template/core/model/weater/weater_data/weather_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weature_state.freezed.dart';
part 'weature_state.g.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    required bool isLoading,
    required WeatherData? weatherData,
    String? errorMessage,
  }) = _WeatherState;

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);
}
