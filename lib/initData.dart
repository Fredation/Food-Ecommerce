import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';

Future initData(BuildContext context) {
  return Future.wait([
    context.read<StoreCubit>().getProducts(),
    context.read<AuthCubit>().getUserData(),
  ]);
}
