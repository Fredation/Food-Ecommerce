import 'package:food_ecommerce/cubit_states.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:get_it/get_it.dart';

export 'package:flutter_bloc/src/bloc_provider.dart';

getProviders(GetIt instance) {
  return <BlocProviderSingleChildWidget>[
    BlocProvider<AuthCubit>(
      create: (context) => instance<AuthCubit>(),
    ),
    BlocProvider<StoreCubit>(
      create: (context) => instance<StoreCubit>(),
    ),
  ];
}
