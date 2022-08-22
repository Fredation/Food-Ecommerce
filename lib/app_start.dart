import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:food_ecommerce/app_injection_component.dart';
import 'package:food_ecommerce/app_setup.dart';
import 'package:food_ecommerce/core/abstractions/feature_resolver.dart';
import 'package:food_ecommerce/core/abstractions/injection_module.dart';
import 'package:food_ecommerce/core/model/build_config.dart';
import 'package:food_ecommerce/my_app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:food_ecommerce/resolver/app_resolver.dart';

abstract class AppStart {
  final BuildConfig buildConfig;

  final resolvers = <FeatureResolver>[
    AppResolver(),
  ];

  AppStart(this.buildConfig);

  Future<void> startApp() async {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    final injectionModule = <InjectionModule>[];

    for (final resolver in resolvers) {
      if (resolver.injectionModule != null) {
        injectionModule.add(resolver.injectionModule!);
      }
    }
    await AppSetup().init();

    final injector = await AppInjectionComponent.instance
        .registerModules(modules: injectionModule, buildConfig: buildConfig);

    await AppSetup().initStorage(injector.get());

    await Firebase.initializeApp();

    await runZonedGuarded<Future<void>>(() async {
      final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

      FirebaseAnalyticsObserver getAnalyticsObserver =
          FirebaseAnalyticsObserver(analytics: _analytics);
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      runApp(
        MyApp(
          buildConfig: buildConfig,
          instance: injector,
          navigatorKey: navigatorKey,
          observer: getAnalyticsObserver,
        ),
      );
    },
        (error, stack) => FirebaseCrashlytics.instance
            .recordError(error, stack, fatal: true));
  }
}
