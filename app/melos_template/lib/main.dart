import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/foundation.dart';
import 'package:core_service/firebase_messaging/firebase_messaging_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // fcm init
  final firebaseMessagingService =
      FirebaseMessagingService(FirebaseMessaging.instance);
  final token = await firebaseMessagingService.token;
  logger.d('FirebaseMessaging token: $token');
  await firebaseMessagingService.requestPermission();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  /// for di_provider
  final sharedPreferences = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();

  final flavor = Flavor.values.byName(const String.fromEnvironment('flavor'));

  runApp(
    ProviderScope(
      overrides: [
        flavorProvider.overrideWithValue(flavor),
        packageInfoProvider.overrideWithValue(packageInfo),
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      observers: const [ProviderLogger()],
      child: const App(),
    ),
  );
}
