import 'package:food_ecommerce/core/abstractions/injection_module.dart';
import 'package:food_ecommerce/core/model/build_config.dart';
import 'package:get_it/get_it.dart';

class AppInjectionComponent {
  static AppInjectionComponent instance = AppInjectionComponent._();

  AppInjectionComponent._();

  Future<GetIt> registerModules({
    required List<InjectionModule> modules,
    required BuildConfig buildConfig,
  }) async {
    var I = GetIt.I;
    for (final module in modules) {
      await module.registerDependencies(injector: I, buildConfig: buildConfig);
    }
    return I;
  }
}
