import 'package:firebase_analytics/firebase_analytics.dart';

class AppFirebaseAnalytics {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver appAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> addTask() async {
    await _analytics.logEvent(
      name: 'add_task',
    );
  }

  Future<void> deleteTask() async {
    await _analytics.logEvent(
      name: 'delete_task',
    );
  }

  Future<void> doneTask() async {
    await _analytics.logEvent(
      name: 'done_task',
    );
  }

  Future<void> logScreens({
    required String? name,
  }) async {
    await _analytics.setCurrentScreen(screenName: name);
  }
}
