import 'package:dio/dio.dart';
import 'package:flutter_app_template/core/foundation/constant/api_endpoint.dart';
import 'package:flutter_app_template/core/model/weater/weater_data/weather_data.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_api_client.g.dart';

@RestApi(baseUrl: ApiEndpoint.openWeather)
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  @GET('/weather')
  Future<WeatherData> getCurrentWeather(
    @Query('q') String city,
    @Query('appid') String apiKey,
  );


}
