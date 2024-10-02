import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_secure_storage_provider.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(
  FlutterSecureStorageRef ref,
) {
  throw FlutterSecureStorage();
}
