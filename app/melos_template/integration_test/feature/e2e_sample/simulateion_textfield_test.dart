import 'package:flutter/material.dart';

import '../../common.dart';
import '../../util/base.dart';
import '../../util/common_operation.dart';

void main() {
  patrol(
    'counter state is the same after going to Home and switching apps',
    ($) async {
      await createApp($);

      await $.introSkip();

      await $.expectAppBarText('home');

      await $.tapByText('E2E Sample');
      await $.expectAppBarText('E2E Sample');

      await $.tapByText('Simulateion TextField Page');
      await $.expectAppBarText('Simulation TextField Page');

      // テキストフィールドに文字を入力
      final textFieldFinder = find.byType(TextField);
      await $.tap(textFieldFinder);
      await $.pumpAndSettle();

      // テキストフィールドが存在することを確認
      expect(textFieldFinder, findsOneWidget);
      await $.enterText(textFieldFinder, 'Hello, Riverpod!');
      await $.pumpAndSettle();

      // Submitボタンをタップ
      final submitButtonFinder = find.text('Submit');
      await $.tap(submitButtonFinder);
      await $.pumpAndSettle();

      // 入力したテキストが表示されていることを確認
      expect(find.text('Submitted Text: Hello, Riverpod!'), findsOneWidget);
    },
  );
}
