import 'package:flutter/foundation.dart';
import 'package:melos_template/core/foundation/constant/e2e_key.dart';

import '../common.dart';
import 'common_native_operation.dart';

extension CommonOperations on PatrolIntegrationTester {
  // イントロダクションスキップ
  Future<void> introSkip() async {
    await tap(find.byKey(Key(E2eKey.introNextKey.name)));
    await pumpAndSettle();

    await tap(find.byKey(Key(E2eKey.introNextKey.name)));

    await waitUntilVisible(find.byKey(Key(E2eKey.introDoneKey.name)));
    await tap(find.byKey(Key(E2eKey.introDoneKey.name)));

    await pumpAndSettle();

    await grantNotificationPermission();
  }
}
