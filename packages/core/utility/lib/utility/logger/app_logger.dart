import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: kDebugMode ? 2 : 0,
    errorMethodCount: 8,
    lineLength: 80,
    printEmojis: true,
  ),
  level: kDebugMode ? Level.debug : Level.warning,
);

void setupLogging() {
  Logger.level = kDebugMode ? Level.debug : Level.warning;
}
