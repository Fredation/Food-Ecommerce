import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/favorite.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';
import 'package:food_ecommerce/features/store/domain/usecases/get_favorites_usecase.dart';
import 'package:food_ecommerce/features/store/domain/usecases/get_products_usecase.dart';
import 'package:food_ecommerce/features/store/domain/usecases/toggle_fav_usecase.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_cubit.freezed.dart';

class StoreCubit extends Cubit<StoreState> {
  GetProductsUsecase getProductsUsecase;
  GetFavoriteUsecase getFavoriteUsecase;
  ToggleFavUsecase toggleFavUsecase;

  StoreCubit({
    required this.getProductsUsecase,
    required this.getFavoriteUsecase,
    required this.toggleFavUsecase,
  }) : super(const StoreState());

  List<Product> _products = [];
  List<Product> get products => _products;

  List<Favorite> _favorites = [];
  List<Favorite> get favorites => _favorites;

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

  Future<void> getFavorites() async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await getFavoriteUsecase(NoParams());
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      _favorites = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
  }

  Future<void> toggleFav({required String pid, required bool isFav}) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await toggleFavUsecase(Favorite(id: pid, isFavorite: isFav));
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      emit(state.copyWith(isLoading: false, error: null));
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
