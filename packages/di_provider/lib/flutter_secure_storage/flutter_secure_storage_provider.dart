import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_secure_storage_provider.g.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: '',
    );

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return FlutterSecureStorage(aOptions: _getAndroidOptions());
}
