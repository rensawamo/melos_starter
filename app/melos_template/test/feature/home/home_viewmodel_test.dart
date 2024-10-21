import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_di_provider/di_provider.dart';
import 'package:core_service/firebase_messaging/firebase_messaging_service.dart';
import 'package:core_test_util/create_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melos_template/feature/home/home_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

import '../../helper/helper_test.mocks.dart';

void main() {
  late MockConnectivity mockConnectivity;
  late ProviderContainer container;
  late HomeViewmodel vm;
  late MockFirebaseMessagingService mockFirebaseMessagingService;
  setUp(() {
    mockConnectivity = MockConnectivity();
    mockFirebaseMessagingService = MockFirebaseMessagingService();

    container = createContainer(
      overrides: [
        connectivityProvider.overrideWithValue(mockConnectivity),
        firebaseMessagingServiceProvider
            .overrideWithValue(mockFirebaseMessagingService),
      ],
    );
    vm = container.read(homeViewmodelProvider.notifier);
  });

  group('HomeViewmodel Tests', () {
    test('checkInternetConnection - No internet connection', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      // Act
      await vm.checkInternetConnection();

      // Assert
      final state = container.read(homeViewmodelProvider);
      expect(state.isInternetConnected, false);
      // verifyNever is used only when using mock. It is not used basically.
      verifyNever(mockFirebaseMessagingService.token);
    });

    test('checkInternetConnection - Internet connection available', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // Act
      await vm.checkInternetConnection();

      // Assert
      final state = container.read(homeViewmodelProvider);
      expect(state.isInternetConnected, true);
      // verifyNever is used only when using mock. It is not used basically.
      verify(mockFirebaseMessagingService.requestPermission()).called(1);
    });
  });
}
