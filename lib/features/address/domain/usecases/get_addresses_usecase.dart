import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/reposiory/address_repo.dart';

class GetAddressesUsecase extends UseCase<List<Address>, NoParams> {
  final AddressRepo repo;

  GetAddressesUsecase(this.repo);

  @override
  Future<Either<Failure, List<Address>>> call(NoParams params) async {
    return await repo.getAddresses();
  }
}
