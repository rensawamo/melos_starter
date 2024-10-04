import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_analitics_service.g.dart';

/// 3rd party 腐敗防止
@Riverpod(keepAlive: true)
FirebaseAnalyticsService firebaseAnalyticsService(
  FirebaseAnalyticsServiceRef ref,
) {
  return FirebaseAnalyticsService(FirebaseAnalytics.instance);
}

class FirebaseAnalyticsService {
  FirebaseAnalyticsService(this._firebaseAnalytics);
  final FirebaseAnalytics _firebaseAnalytics;

  /// Logs an event with the specified [name] and optional [parameters].
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _firebaseAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  // key event
  Future<void> logKeyEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _firebaseAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  /// Sets the user ID to [userId] for the current session
  Future<void> setUserId(String userId) async {
    await _firebaseAnalytics.setUserId(id: userId);
  }

  /// Sets a user property with the specified [name] and [value].
  ///  prefecture :  tokyo みたいな限定テストなどに使う
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    await _firebaseAnalytics.setUserProperty(
      name: name,
      value: value,
    );
  }

  ///  Future<void> setCurrentScreen({ これは現在非推奨   logeventをobserverに仕込んでとる
}
