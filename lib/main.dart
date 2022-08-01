import 'package:flutter/foundation.dart';
import 'package:food_ecommerce/app_start.dart';
import 'package:food_ecommerce/core/model/build_config.dart';

void main() {
  if (kReleaseMode) {
    ProductionApp().startApp();
  } else {
    StagingApp().startApp();
  }
}

class ProductionApp extends AppStart {
  ProductionApp()
      : super(ProductionBuildConfig(
            baseUrl:
                "https://food-e-commerce-dd2e0-default-rtdb.firebaseio.com/",
            appName: 'Food-ECommerce'));
}

class ProductionBuildConfig extends BuildConfig {
  ProductionBuildConfig({required String baseUrl, required String appName})
      : super(baseUrl: baseUrl, appName: appName);
}

class StagingApp extends AppStart {
  StagingApp()
      : super(StagingBuildConfig(
            baseUrl:
                "https://food-e-commerce-dd2e0-default-rtdb.firebaseio.com/",
            appName: 'Food-ECommerce Staging'));
}

class StagingBuildConfig extends BuildConfig {
  StagingBuildConfig({required String baseUrl, required String appName})
      : super(baseUrl: baseUrl, appName: appName);
}
