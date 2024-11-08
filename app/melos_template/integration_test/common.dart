import 'package:flutter_test/flutter_test.dart';
import 'package:melos_template/main.dart' as app_main;
import 'package:patrol/patrol.dart';

export 'package:flutter_test/flutter_test.dart';
export 'package:patrol/patrol.dart';

const _patrolTesterConfig = PatrolTesterConfig(
  visibleTimeout: Duration(seconds: 20),
  settleTimeout: Duration(seconds: 20),
  existsTimeout: Duration(seconds: 20),
);
const _nativeAutomatorConfig = NativeAutomatorConfig(
  findTimeout: Duration(seconds: 20),
);

Future<void> createApp(PatrolIntegrationTester $) async {
  await app_main.main();
  await $.pumpAndSettle();
}

void patrol(
  String description,
  Future<void> Function(PatrolIntegrationTester) callback, {
  bool? skip,
  List<String> tags = const [],
  NativeAutomatorConfig? nativeAutomatorConfig,
  LiveTestWidgetsFlutterBindingFramePolicy framePolicy =
      LiveTestWidgetsFlutterBindingFramePolicy.fadePointers,
}) {
  patrolTest(
    description,
    config: _patrolTesterConfig,
    nativeAutomatorConfig: nativeAutomatorConfig ?? _nativeAutomatorConfig,
    framePolicy: framePolicy,
    skip: skip,
    callback,
    tags: tags,
  );
}
