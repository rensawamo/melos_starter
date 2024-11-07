import 'package:core_ui/widget/app_base_frame.dart';
import 'package:flutter/material.dart';

import '../common.dart';

extension CommonOperations on PatrolIntegrationTester {
  // appbar の文字を識別
  Future<void> expectAppBarText(String text) async {
    final appbaseframe = find.byType(AppBarFrame);
    final appBar =
        find.descendant(of: appbaseframe, matching: find.byType(AppBar));
    await expectLater(
      find.descendant(of: appBar, matching: find.text(text)),
      findsOneWidget,
    );
  }

  // textを入力して、キーボードを閉じる
  Future<void> inputTextAndCloseKeyboard(String text, int? index) async {
    // await waitUntilVisible(find.byType(TextField));
    await enterText(find.byType(TextField).at(index ?? 0), text);
    await pumpAndSettle();
  }

  // Flutter のテキストをタップ
  Future<void> tapByText(String text) async {
    await tap(find.text(text));
    await pumpAndSettle();
  }
}
