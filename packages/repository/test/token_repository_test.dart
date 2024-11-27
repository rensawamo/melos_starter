// import 'dart:io';

// import 'package:core_di_provider/di_provider.dart';
// import 'package:core_foundation/foundation.dart';
// import 'package:core_repository/repository.dart';
// import 'package:core_test_util/test_util.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:riverpod/riverpod.dart';

// void main() {
//   group('TokenRepository', () {
//     late ProviderContainer container;
//     late TokenRepository tokenRepository;
//     late FakeSecureStorage fakeSecureStorage;
//     final key = AppSecureStorageKey.appTokenRepositoryKey.name;

//     setUp(() {
//       fakeSecureStorage = FakeSecureStorage();
//       container = createContainer(
//         overrides: [
//           secureStorageProvider.overrideWithValue(fakeSecureStorage),
//         ],
//       );
//       tokenRepository = container.read(tokenRepositoryProvider);
//     });

//     test('should save token in secure storage', () async {
//       // Arrange
//       const token = 'test_token';

//       // Act
//       await tokenRepository.saveToken(token);

//       // Assert
//       final storedToken = await fakeSecureStorage.read(key: key);
//       expect(storedToken, equals(token));
//       expect(tokenRepository.cachedToken, equals(token));
//     });

//     test('should load token from secure storage', () async {
//       // Arrange
//       const token = 'test_token';
//       await fakeSecureStorage.write(key: key, value: token);

//       // Act
//       final loadedToken = await tokenRepository.loadToken();

//       // Assert
//       expect(loadedToken, equals(token));
//     });

//     // test('should return empty string if token is not found in secure storage',
//     //     () async {
//     //   // Act
//     //   final loadedToken = await tokenRepository.loadToken();

//     //   // Assert
//     //   expect(loadedToken, equals(''));
//     // });

//     test('should delete token from secure storage', () async {
//       // Arrange
//       const token = 'test_token';
//       await fakeSecureStorage.write(key: key, value: token);

//       // Act
//       await tokenRepository.deleteToken();

//       // Assert
//       final storedToken = await fakeSecureStorage.read(key: key);
//       expect(storedToken, isNull);
//       expect(tokenRepository.cachedToken, equals(''));
//     });

//     test('should save token from cookies', () async {
//       // Arrange
//       const tokenValue = 'cookie_token';
//       final cookies = [Cookie(key, tokenValue)];

//       // Act
//       await tokenRepository.saveTokenFromCookies(cookies);

//       // Assert
//       final storedToken = await fakeSecureStorage.read(key: key);
//       expect(storedToken, equals(tokenValue));
//       expect(tokenRepository.cachedToken, equals(tokenValue));
//     });

//     test('should throw authentication error if token is not found in cookies'
// ,
//         () async {
//       // Arrange
//       final cookies = [Cookie('some_other_key', 'value')];

//       // Act & Assert
//       expect(
//         () => tokenRepository.saveTokenFromCookies(cookies),
//         throwsA(isA<AppError>()),
//       );
//     });

//     test('should return cached token if it exists', () async {
//       // Arrange
//       const token = 'cached_token';
//       tokenRepository.cachedToken = token;

//       // Act
//       final retrievedToken = await tokenRepository.getToken();

//       // Assert
//       expect(retrievedToken, equals(token));
//     });

//     test('should load token from storage if cache is empty', () async {
//       // Arrange
//       const token = 'stored_token';
//       await fakeSecureStorage.write(key: key, value: token);
//       tokenRepository.cachedToken = '';

//       // Act
//       final retrievedToken = await tokenRepository.getToken();

//       // Assert
//       expect(retrievedToken, equals(token));
//     });
//   });
// }
