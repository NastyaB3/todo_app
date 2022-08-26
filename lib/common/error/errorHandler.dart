import 'package:flutter/material.dart';
import 'package:todo_app/common/error/logging.dart';
import 'package:flutter/foundation.dart';


//TODO: доделать во второй фазе
class ErrorHandler {
  static void init() {
    FlutterError.onError = _recordFlutterError;
    logger.info('ErrorHandler initialized');
  }

  static void recordError(Object error, StackTrace stackTrace) {
    logger.severe(
      error.toString(),
      error,
      stackTrace,
    );
  }

  static void _recordFlutterError(FlutterErrorDetails error) {
    logger.severe(error.toStringShort(), error.exception, error.stack);
  }

  const ErrorHandler._();
}
