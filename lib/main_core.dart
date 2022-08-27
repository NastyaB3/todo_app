import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/di/app_config.dart';
import 'package:todo_app/common/error/error_handler.dart';
import 'package:todo_app/common/error/logging.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/my_app_widget.dart';
import 'package:todo_app/navigation/app_route_information_parser.dart';
import 'package:todo_app/navigation/router_delegate.dart';
import 'package:todo_app/screens/list_todo_screen/main_screen.dart';

final parser = AppRouteInformationParser();
final router = TodoRouterDelegate();


void mainCore() {
  router.replaceAll(ListTodoScreen.newPage());
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
    runApp(const MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}
