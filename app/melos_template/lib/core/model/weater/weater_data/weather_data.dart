import 'package:flutter_app_template/core/model/weater/cloud/cloud.dart';
import 'package:flutter_app_template/core/model/weater/coord/coord.dart';
import 'package:flutter_app_template/core/model/weater/main/main.dart';
import 'package:flutter_app_template/core/model/weater/sys/sys.dart';
import 'package:flutter_app_template/core/model/weater/weather/weather.dart';
import 'package:flutter_app_template/core/model/weater/wind/wind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_data.freezed.dart';
part 'weather_data.g.dart';

@freezed
class WeatherData with _$WeatherData {
  const factory WeatherData({
    required Coord coord,
    required List<Weather> weather,
    required Main main,
    required Wind wind,
    required Cloud clouds,
    required Sys sys,
    required String name,
    required int cod,
  }) = _WeatherData;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}
