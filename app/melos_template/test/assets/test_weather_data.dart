import 'package:melos_template/core/model/weater/main/main.dart';
import 'package:melos_template/core/model/weater/weater_data/weather_data.dart';
import 'package:melos_template/core/model/weater/weather/weather.dart';
import 'package:melos_template/core/model/weater/wind/wind.dart';

const testWeatherData = WeatherData(
  weather: [
    Weather(
      id: 803,
      main: 'Clouds',
      description: 'broken clouds',
      icon: '04d',
    ),
  ],
  main: Main(
    temp: 289.18,
    feels_like: 288.85,
    temp_min: 288.52,
    temp_max: 290.12,
    pressure: 1016,
    humidity: 77,
    sea_level: 1016,
    grnd_level: 1011,
  ),
  wind: Wind(
    speed: 3.6,
    deg: 340,
  ),
  name: 'Tokyo',
);
