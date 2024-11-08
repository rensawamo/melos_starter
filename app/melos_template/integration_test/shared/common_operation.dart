import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';

import '../common.dart';

extension CommonOperations on PatrolIntegrationTester {
  Future<void> expectAppCircleIndicator(WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    expect(find.byType(AppCircleIndicator), findsOneWidget);
  }

  Future<void> inputTextField(String text) async {
    final textFieldFinder = find.byType(TextField);
    await tap(textFieldFinder);
    await pumpAndSettle();
    expect(textFieldFinder, findsOneWidget);
    await enterText(textFieldFinder, text);
    await pumpAndSettle();
  }

  Future<void> tapByText(String text) async {
    await tap(find.text(text));
    await pumpAndSettle();
  }
}
