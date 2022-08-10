import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  AddToCartUsecase addToCartUsecase;
  GetCartUsecase getCartUsecase;
  RemoveFromCartUsecase removeFromCartUsecase;
  CartCubit({
    required this.addToCartUsecase,
    required this.getCartUsecase,
    required this.removeFromCartUsecase,
  }) : super(const CartState());

  List<Product> cart = [];

  Future<void> addToCart({required Product prod}) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await addToCartUsecase(prod);
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      emit(state.copyWith(isLoading: false, error: null));
    });
  }

  Future<void> removeFromCart({required Product prod}) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await removeFromCartUsecase(prod);
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      emit(state.copyWith(isLoading: false, error: null));
    });
  }

  Future<void> getCart() async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await getCartUsecase(NoParams());
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      cart.clear();
      cart.addAll(r);
      emit(state.copyWith(isLoading: false, data: r));
    });
  }

  double getSubTotal() {
    final v =
        cart.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
    emit(state.copyWith(data: v));
    return v;
  }
}

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default(false) isLoading,
    Failure? error,
    dynamic data,
  }) = _CartState;
}
