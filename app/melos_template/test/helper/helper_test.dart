import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_service/firebase_messaging/firebase_messaging_service.dart';
import 'package:melos_template/core/network/api_client/weather_api_client.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<WeatherApiClient>()])
@GenerateNiceMocks([MockSpec<Connectivity>()])
@GenerateNiceMocks([MockSpec<FirebaseMessagingService>()])
void main() {}
