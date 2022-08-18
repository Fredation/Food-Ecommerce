import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/entities/recipient.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_cart_add_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_recipient_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/get_cart_add_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/get_recipient_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  AddToCartUsecase addToCartUsecase;
  GetCartUsecase getCartUsecase;
  RemoveFromCartUsecase removeFromCartUsecase;
  AddCartAddressUsecase addCartAddressUsecase;
  AddRecipientUsecase addRecipientUsecase;
  GetRecipientUsecase getRecipientUsecase;
  GetCartAddressUsecase getCartAddressUsecase;
  CartCubit({
    required this.addToCartUsecase,
    required this.getCartUsecase,
    required this.removeFromCartUsecase,
    required this.addCartAddressUsecase,
    required this.addRecipientUsecase,
    required this.getCartAddressUsecase,
    required this.getRecipientUsecase,
  }) : super(const CartState());

  List<Product> cart = [];
  Address? cartAddress;
  Recipient? recipient;

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

  Future<void> addCartAddress({
    required String houseNumber,
    required String street,
    required String city,
    required String states,
    required String country,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await addCartAddressUsecase(AddressParams(
      city: city,
      country: country,
      houseNumber: houseNumber,
      state: states,
      street: street,
    ));
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      cartAddress = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
  }

  Future<void> addRecipient({
    required String name,
    required String phone,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await addRecipientUsecase(ReciParams(
      name: name,
      phone: phone,
    ));
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      recipient = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
  }

  Future<void> getCartAddress() async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await getCartAddressUsecase(NoParams());
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      cartAddress = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
  }

  Future<void> getRecipient() async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await getRecipientUsecase(NoParams());
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      recipient = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
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
