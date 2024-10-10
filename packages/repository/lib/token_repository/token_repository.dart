import 'dart:io';

import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_repository.g.dart';

@Riverpod(keepAlive: true)
TokenRepository tokenRepository(TokenRepositoryRef ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return TokenRepositoryImpl(secureStorage);
}

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;
  final _key = AppSecureStorageKey.appTokenRepositoryKey;
  @override
  String cachedToken = '';

  @override
  Future<AppError?> saveTokenFromCookies(
    List<Cookie> cookies,
  ) async {
    for (final cookie in cookies) {
      if (cookie.name == _key.name) {
        await _secureStorage.write(key: _key.name, value: cookie.value);
        cachedToken = cookie.value;
        logger.i('Token saved to secure storage: ${cookie.value}');
        return null;
      }
    }
    logger.w('Token not found in cookies.');
    throw AppError.authenticationError();
  }

  @override
  Future<void> saveToken(String value) async {
    await _secureStorage.write(key: _key.name, value: value);
    cachedToken = value;
    logger.i('Token saved to secure storage: $value');
  }

  @override
  Future<String> loadToken() async {
    final token = await _secureStorage.read(key: _key.name);
    if (token == '' || token == null) {
      logger.w('Token not found for key: ${_key.name}');
      return '';
    }
    logger.i('Token successfully loaded for key: ${_key.name}');
    return token;
  }

  @override
  Future<Error?> deleteToken() async {
    try {
      await _secureStorage.delete(key: _key.name);
      await _invalidateToken();
      logger.i('Token successfully deleted for key: ${_key.name}');
      return null;
    } catch (e) {
      logger.e('Error deleting token: $e');
      throw AppError.notFound();
    }
  }

  @override
  Future<String> getToken() async {
    if (cachedToken.isNotEmpty) {
      logger.d('Using cached token');
      return cachedToken;
    }
    logger.d('Loading token from storage');

    return loadToken();
  }

  Future<void> _invalidateToken() async {
    cachedToken = '';
  }
}

abstract class TokenRepository {
  String cachedToken = '';

  // Save the token from the list of cookies
  Future<AppError?> saveTokenFromCookies(List<Cookie> cookies);
  // Save the token in secure storage
  Future<void> saveToken(String value);
  // Retrieve the token
  Future<String> loadToken();
  // Delete the token
  Future<Error?> deleteToken();
  // Retrieve the cached token
  Future<String> getToken();
}
