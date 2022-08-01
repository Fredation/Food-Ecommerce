import 'package:food_ecommerce/core/abstractions/feature_resolver.dart';
import 'package:food_ecommerce/core/abstractions/injection_module.dart';
import 'package:food_ecommerce/resolver/app_injection_module.dart';

class AppResolver implements FeatureResolver {
  @override
  InjectionModule? get injectionModule => AppInjectionModule();
}
