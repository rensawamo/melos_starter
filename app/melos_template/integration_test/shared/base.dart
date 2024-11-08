import 'package:core_foundation/foundation.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:melos_template/core/foundation/constant/e2e_key.dart';

import '../common.dart';
import 'permisson/common_native_operation.dart';

extension CommonOperations on PatrolIntegrationTester {
  Future<void> introSkip() async {
    await tap(find.byKey(Key(E2eKey.introNextKey.name)));
    await pumpAndSettle();

    await tap(find.byKey(Key(E2eKey.introNextKey.name)));

    await waitUntilVisible(find.byKey(Key(E2eKey.introDoneKey.name)));
    await tap(find.byKey(Key(E2eKey.introDoneKey.name)));

    await pumpAndSettle();

    await grantNotificationPermission();
  }

  Future<void> expectAppBarText(String text) async {
    final appBar = find.descendant(
      of: find.byType(AppBarFrame),
      matching: find.byType(AppBar),
    );
    await expectLater(
      find.descendant(of: appBar, matching: find.text(text)),
      findsOneWidget,
    );
  }

  // AppErrorDialogを表示しているか確認
  Future<void> expectAppErrorDialog(AppError error) async {
    final title = find.text(error.type.value);
    expect(title, findsOneWidget);
  }
}
