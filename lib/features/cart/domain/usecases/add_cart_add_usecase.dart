import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';

class AddCartAddressUsecase extends UseCase<Address, AddressParams> {
  final CartRepo repo;

  AddCartAddressUsecase(this.repo);

  @override
  Future<Either<Failure, Address>> call(AddressParams params) async {
    return await repo.addCartAddress(params);
  }
}
