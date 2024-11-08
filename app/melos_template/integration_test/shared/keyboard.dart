import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;

class TestKeyboard {
  static Future<void> simulateKeyDownEvent(
    List<LogicalKeyboardKey> keys, {
    required flutter_test.WidgetTester tester,
    bool withKeyUp = false,
  }) async {
    for (final key in keys) {
      await flutter_test.simulateKeyDownEvent(key);
      await tester.pumpAndSettle();
    }

    if (withKeyUp) {
      for (final key in keys) {
        await flutter_test.simulateKeyUpEvent(key);
        await tester.pumpAndSettle();
      }
    }
  }
}
