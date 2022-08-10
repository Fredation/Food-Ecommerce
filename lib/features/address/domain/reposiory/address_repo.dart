import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';

abstract class AddressRepo {
  Future<Either<Failure, void>> createAddress(AddressParams data);
  Future<Either<Failure, List<Address>>> getAddresses();
  Future<Either<Failure, void>> deleteAddress(String aid);
}
