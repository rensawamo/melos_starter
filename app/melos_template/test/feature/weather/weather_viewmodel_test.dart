// import 'package:core_foundation/foundation.dart';
// import 'package:core_test_util/create_container.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:melos_template/core/network/api_client/weather_api_client.dart';
// import 'package:melos_template/feature/weature/weature_viewmodel.dart';
// import 'package:mockito/mockito.dart';

// import '../../assets/test_dio_exception.dart';
// import '../../assets/test_weather_data.dart';
// import '../../helper/helper_test.mocks.dart';

// void main() {
//   late ProviderContainer container;
//   late MockWeatherApiClient mockWeatherApiClient;
//   late WeatherViewmodel vm;

//   setUp(() {
//     mockWeatherApiClient = MockWeatherApiClient();
//     container = createContainer(
//       overrides: [
//         weatherApiClientProvider.overrideWithValue(mockWeatherApiClient),
//       ],
//     );
//     vm = container.read(weatherViewmodelProvider.notifier);
//   });

//   test('fetchWeather success', () async {
//     // Arrange
//     when(mockWeatherApiClient.getCurrentWeather('Tokyo', any))
//         .thenAnswer((_) async => testWeatherData);

//     // Act
//     final result = await vm.call('Tokyo');

//     // Assert
//     final state = container.read(weatherViewmodelProvider);
//     expect(result, isNull);
//     expect(state.isLoading, false);
//     expect(state.weatherData, testWeatherData);
//   });

//   test('fetchWeather failure', () async {
//     // Arrange

//     when(mockWeatherApiClient.getCurrentWeather('Tokyo', any)).thenThrow(
//       testDioNetworkException,
//     );

//     // Act
//     final result = await vm.call('Tokyo');

//     // Assert
//     final state = container.read(weatherViewmodelProvider);
//     expect(result?.type, AppErrorType.networkError);
//     expect(state.isLoading, false);
//     expect(state.weatherData, isNull);
//   });

//   test('fetchWeather unknown error', () async {
//     // Arrange
//     when(mockWeatherApiClient.getCurrentWeather('Tokyo', any)).thenThrow(
//       Exception(''),
//     );

//     // Act
//     final result = await vm.call('Tokyo');

//     // Assert
//     final state = container.read(weatherViewmodelProvider);
//     expect(result?.type, AppErrorType.unknownError);
//     expect(state.isLoading, false);
//     expect(state.weatherData, isNull);
//   });
// }
