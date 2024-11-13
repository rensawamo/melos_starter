import 'package:core_foundation/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melos_template/core/foundation/constant/api_endpoint.dart';
import 'package:melos_template/core/model/weater/weater_data/weather_data.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_api_client.g.dart';

@riverpod
WeatherApiClient weatherApiClient(Ref ref) {
  final dio = ref.read(dioProvider(isRequireAuthenticate: false));
  return WeatherApiClient(dio, baseUrl: ApiEndpoint.openWeather);
}

@RestApi(baseUrl: ApiEndpoint.openWeather)
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  @GET('/weather')
  Future<WeatherData> getCurrentWeather(
    @Query('q') String city,
    @Query('appid') String apiKey,
  );
}
