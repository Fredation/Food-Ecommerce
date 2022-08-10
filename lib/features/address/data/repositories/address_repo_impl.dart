import 'package:food_ecommerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/features/address/data/datasources/address_ds.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/reposiory/address_repo.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';

class AddressRepoImpl implements AddressRepo {
  final AddressDS addressDS;
  AddressRepoImpl({required this.addressDS});

  @override
  Future<Either<Failure, void>> createAddress(AddressParams data) async {
    try {
      final res = await addressDS.createAddress(data);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Address>>> getAddresses() async {
    try {
      final res = await addressDS.getAddresses();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String aid) async {
    try {
      final res = await addressDS.deleteAddress(aid);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
