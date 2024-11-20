import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'notification_service_provider.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(
  Ref ref,
) {
  final service = NotificationService(
    FlutterLocalNotificationsPlugin(),
    BehaviorSubject<String?>(),
  );
  ref.onDispose(service.onNotification.close);
  return service;
}

class NotificationService {
  const NotificationService(
    this._localNotifications,
    this.onNotification,
  );
  final FlutterLocalNotificationsPlugin _localNotifications;
  final BehaviorSubject<String?> onNotification;

  Future<void> init() async {
    await _initializeNotificationSettings();
    await _askAndroidPermission();
    await _initTimeZone();
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    final notificationDetails = await _getNotificationDetails();
    await _localNotifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> showSchedueledNotification({
    required DateTime scheduledDate,
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    final notificationDetails = await _getNotificationDetails();
    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> _initializeNotificationSettings() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestCriticalPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinSettings,
    );

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.notificationResponse?.payload);
    }

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) =>
          onNotification.add(details.payload),
    );
  }

  Future<bool?>? _askAndroidPermission() => _localNotifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  Future<void> _initTimeZone() async {
    tz.initializeTimeZones();
    // final locationName = await FlutterNativeTimezone.getLocalTimezone();
    final locationName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }

  Future<NotificationDetails> _getNotificationDetails() async {
    const androidDetails = AndroidNotificationDetails(
      'melos_template_channel_id',
      'melos_template_notifications',
      channelDescription: 'melos_template notification channel',
      importance: Importance.max,
      groupKey: 'com.example.melos_template',
    );
    const darwinDetails =
        DarwinNotificationDetails(threadIdentifier: 'melos_template_id');
    return const NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );
  }
}
