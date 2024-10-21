import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/foundation.dart';
import 'package:core_service/firebase_messaging/firebase_messaging_service.dart';
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

  Future<void> init() async {
    final firebaseMessagingService =
        ref.watch(firebaseMessagingServiceProvider);
    await firebaseMessagingService.requestPermission();

    final token = await firebaseMessagingService.token;
    logger.d('FirebaseMessaging token: $token');

    firebaseMessagingService.messageStream.listen((message) {
      logger.d('Received a message: ${message.notification?.title}');
    });
    firebaseMessagingService.openedAppStream.listen((message) {
      logger.d('Opened app from a message: ${message.notification?.title}');
    });
  }
}
