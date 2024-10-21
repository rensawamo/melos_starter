// widget が破壊されたら自動的に破棄される
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'text_controller_provider.g.dart';

@riverpod
class TextController extends _$TextController {
  @override
  TextEditingController build() {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);
    return controller;
  }
}
