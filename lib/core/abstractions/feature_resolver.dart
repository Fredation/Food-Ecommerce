import 'package:food_ecommerce/core/abstractions/injection_module.dart';

///Resolves dependencies and routers.
///Dependencies such as [Injector] and [Router] are resolved here.

abstract class FeatureResolver {
  InjectionModule? get injectionModule;
}
