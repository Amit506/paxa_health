import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as Log;

class AppLogger {
  static final AppLogger _loggerInstance = AppLogger._makeInstance();

  factory AppLogger() {
    return _loggerInstance;
  }

  AppLogger._makeInstance();

  static final _logger = Log.Logger(
    printer: Log.PrettyPrinter(
      printEmojis: true,
      printTime: false,
      methodCount: 0,
    ),
  );

  static void print(value, {bool print = true}) {
    if (!kReleaseMode && print) {
      _logger.d(value);
    }
  }

  static void info(value, {bool print = true}) {
    if (!kReleaseMode && print) {
      _logger.i(value);
    }
  }

  static void error(String e, StackTrace s) {
    _logger.e(
      e,
    );
  }
}
