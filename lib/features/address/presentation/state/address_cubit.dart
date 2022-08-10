import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';
import 'package:food_ecommerce/features/address/domain/usecases/delete_address_usecase.dart';
import 'package:food_ecommerce/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_cubit.freezed.dart';

class AddressCubit extends Cubit<AddressState> {
  CreateAddressUsecase createAddressUsecase;
  GetAddressesUsecase getAddressesUsecase;
  DeleteAddressUsecase deleteAddressUsecase;
  AddressCubit({
    required this.createAddressUsecase,
    required this.getAddressesUsecase,
    required this.deleteAddressUsecase,
  }) : super(const AddressState());

  List<Address> _addresses = [];
  List<Address> get addresses => _addresses;

  Future<void> createAddress({
    required String houseNumber,
    required String street,
    required String city,
    required String states,
    required String country,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await createAddressUsecase(AddressParams(
      city: city,
      country: country,
      houseNumber: houseNumber,
      state: states,
      street: street,
    ));
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      emit(state.copyWith(isLoading: false, error: null));
    });
  }

  Future<void> getAddresses() async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await getAddressesUsecase(NoParams());
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      _addresses = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
  }

  Future<void> deleteAddress({required String aid}) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await deleteAddressUsecase(aid);
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      emit(state.copyWith(isLoading: false, error: null));
    });
  }
}

@freezed
abstract class AddressState with _$AddressState {
  const factory AddressState({
    @Default(false) isLoading,
    Failure? error,
    dynamic data,
  }) = _AddressState;
}
