import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/address/domain/reposiory/address_repo.dart';

class CreateAddressUsecase extends UseCase<void, AddressParams> {
  final AddressRepo repo;

  CreateAddressUsecase(this.repo);

  @override
  Future<Either<Failure, void>> call(AddressParams params) async {
    return await repo.createAddress(params);
  }
}

class AddressParams {
  AddressParams({
    required this.houseNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
  });
  final String houseNumber;
  final String street;
  final String city;
  final String state;
  final String country;
}
