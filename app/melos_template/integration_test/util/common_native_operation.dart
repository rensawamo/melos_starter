import '../common.dart';

extension CommonOperations on PatrolIntegrationTester {
  Future<void> grantNotificationPermission() async {
    await native2.tap(
      NativeSelector(
        android: AndroidSelector(text: 'Allow'),
        ios: IOSSelector(label: 'Allow'),
      ),
    );
    await pumpAndSettle();
  }
}
