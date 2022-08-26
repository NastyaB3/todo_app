import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/di/app_config.dart';
import 'package:todo_app/common/error/errorHandler.dart';
import 'package:todo_app/common/error/logging.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/my_app_widget.dart';

void main() async {
  configureDependencies();
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    initLogger();
    logger.info('Start main');
    ErrorHandler.init();
    runApp(MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}
