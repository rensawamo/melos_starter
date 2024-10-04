import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scroll_controller_provider.g.dart';

// widget が破壊されたら自動的に破棄される
@riverpod
class ScrollBarController extends _$ScrollBarController {
  @override
  ScrollController build() {
    var controller = ScrollController();
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}
