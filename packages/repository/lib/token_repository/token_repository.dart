import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/foundation.dart';
import 'package:core_model/token_state/token_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_repository.g.dart';

@Riverpod(keepAlive: true)
class TokenRepository extends _$TokenRepository {
  late final FlutterSecureStorage _secureStorage;
  final _key = AppSecureStorageKey.appTokenRepositoryKey;

  @override
  TokenState build() {
    _secureStorage = ref.read(secureStorageProvider);
    state = const TokenState();
    loadToken();
    return state;
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _key.name, value: token);

    state = state.copyWith(token: token);
    logger.i('Token saved: $token');
  }

  Future<String> loadToken() async {
    final token = await _secureStorage.read(key: _key.name);

    state = state.copyWith(token: token ?? '');
    logger.i('Token loaded: ${token ?? 'No token'}');
    return token ?? 'No token';
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _key.name);

    state = const TokenState();
    logger.i('Token deleted');
  }
}
