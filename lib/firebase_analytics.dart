import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver getAnalyticsObserver =
      FirebaseAnalyticsObserver(analytics: _analytics);
}
