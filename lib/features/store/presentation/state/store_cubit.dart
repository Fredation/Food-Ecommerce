import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';
import 'package:food_ecommerce/features/store/domain/usecases/get_products_usecase.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_cubit.freezed.dart';

class StoreCubit extends Cubit<StoreState> {
  GetProductsUsecase getProductsUsecase;
  StoreCubit({required this.getProductsUsecase}) : super(const StoreState());

  List<Product> _products = [];
  List<Product> get products => _products;

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  Future<void> getProducts() async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await getProductsUsecase(NoParams());
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      _products = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
  }
}

@freezed
abstract class StoreState with _$StoreState {
  const factory StoreState({
    @Default(false) isLoading,
    Failure? error,
    dynamic data,
  }) = _StoreState;
}
