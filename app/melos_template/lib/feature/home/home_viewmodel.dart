import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_di_provider/di_provider.dart';
import 'package:core_service/service.dart';
import 'package:core_utility/utility.dart';
import 'package:melos_template/feature/home/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  @override
  HomeState build() {
    return const HomeState(
      isInternetConnected: false,
    );
  }

  Future<void> init() async {
    try {
      
      

      final firebaseMessagingService =
          ref.read(firebaseMessagingServiceProvider);
      await firebaseMessagingService.requestPermission();

      final token = await firebaseMessagingService.token;
      logger.d('FirebaseMessaging token: $token');

      _setupFirebaseMessagingListeners(firebaseMessagingService);
    } catch (e) {
      logger.e('Failed to initialize Firebase Messaging: $e');
    }
  }

  void _setupFirebaseMessagingListeners(FirebaseMessagingService service) {
    service.messageStream.listen((message) {
      logger.d('Received a message: ${message.notification?.title}');
    });

    service.openedAppStream.listen((message) {
      logger.d('Opened app from a message: ${message.notification?.title}');
    });
  }

  Future<bool> checkInternetConnection() async {
    final connectivity = ref.read(connectivityProvider);
    final result = await connectivity.checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      state = state.copyWith(isInternetConnected: false);
    } else {
      state = state.copyWith(isInternetConnected: true);
      await init();
    }

    return state.isInternetConnected;
  }
}
