import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_service/service.dart';
import 'package:melos_template/core/network/api_client/weather_api_client.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<WeatherApiClient>()])
@GenerateNiceMocks([MockSpec<Connectivity>()])
@GenerateNiceMocks([MockSpec<FirebaseMessagingService>()])
@GenerateNiceMocks([MockSpec<NotificationService>()])
void main() {}
