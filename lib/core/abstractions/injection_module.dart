import 'dart:async';

import 'package:food_ecommerce/core/model/build_config.dart';
import 'package:get_it/get_it.dart';

abstract class InjectionModule {
  FutureOr<void> registerDependencies(
      {required GetIt injector, required BuildConfig buildConfig});
}
