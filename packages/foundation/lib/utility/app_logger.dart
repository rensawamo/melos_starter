import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
  level: kDebugMode ? Level.debug : Level.warning,
);

void setupLogging() {
  Logger.level = kDebugMode ? Level.debug : Level.warning;
}
