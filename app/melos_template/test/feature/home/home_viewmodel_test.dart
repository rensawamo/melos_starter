import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_di_provider/di_provider.dart';
import 'package:core_service/firebase_messaging/firebase_messaging_service.dart';
import 'package:core_service/notification_service/notification_service_provider.dart';
import 'package:core_test_util/create_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melos_template/feature/home/home_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

import '../../helper/helper_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockFirebaseMessagingService mockFirebaseMessagingService;
  late MockNotificationService mockNotificationService;
  late MockConnectivity mockConnectivity;
  late HomeViewmodel vm;

  setUp(() {
    // Set up mock instances
    mockFirebaseMessagingService = MockFirebaseMessagingService();
    mockNotificationService = MockNotificationService();
    mockConnectivity = MockConnectivity();

    // Initialize Riverpod container
    container = createContainer(
      overrides: [
        firebaseMessagingServiceProvider
            .overrideWithValue(mockFirebaseMessagingService),
        notificationServiceProvider.overrideWithValue(mockNotificationService),
        connectivityProvider.overrideWithValue(mockConnectivity),
      ],
    );
    // vm testing
    vm = container.read(homeViewmodelProvider.notifier);
  });

  test('checkInternetConnection returns true when internet is connected',
      () async {
    // Mock the connectivity to return a valid connection
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);

    // Call checkInternetConnection
    final result = await vm.checkInternetConnection();
    final state = container.read(homeViewmodelProvider);

    // verifyNever is used only when using mock. It is not used basically.
    verify(mockNotificationService.init()).called(1);
    verify(mockFirebaseMessagingService.requestPermission()).called(1);

    // Expect result and state to be true for internet connection
    expect(result, true);
    expect(state.isInternetConnected, true);
  });

  test('checkInternetConnection returns false when no internet', () async {
    // Mock the connectivity to return no connection
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none]);

    // Call checkInternetConnection
    final result = await vm.checkInternetConnection();
    final state = container.read(homeViewmodelProvider);

    // verifyNever is used only when using mock. It is not used basically.
    verifyNever(mockNotificationService.init());
    verifyNever(mockFirebaseMessagingService.requestPermission());

    expect(result, false);
    expect(state.isInternetConnected, false);
  });
}
