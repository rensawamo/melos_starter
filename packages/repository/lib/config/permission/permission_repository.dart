import 'package:app_settings/app_settings.dart';
import 'package:core_di_provider/di_provider.dart';
import 'package:core_repository/config/permission/model/permission_state.dart';
import 'package:core_utility/provider/life_cycle/app_lifecycle_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_repository.g.dart';

@riverpod
class PermissionRepository extends _$PermissionRepository {
  @override
  PermissionStateModel build() {
    ref.listen(appLifecycleStateProvider, (_, next) {
      if (next == AppLifecycleState.resumed) {
        _initState();
      }
    });
    return const PermissionStateModel();
  }

  Future<void> _initState() async {
    final notificationPermission =
        await ref.read(firebaseMessagingProvider).getNotificationSettings();
    await ref
        .read(firebaseMessagingProvider)
        .setForegroundNotificationPresentationOptions(
          alert: true,
          sound: true,
        );

    state = PermissionStateModel(
      notification: switch (notificationPermission.authorizationStatus) {
        AuthorizationStatus.authorized ||
        AuthorizationStatus.provisional =>
          true,
        _ => false,
      },
    );
  }

  Future<void> requestNotificationPermission() async {
    final result =
        await ref.read(firebaseMessagingProvider).requestPermission();
    if (result.authorizationStatus == AuthorizationStatus.denied) {
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
    ref.invalidateSelf();
  }
}
