import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/address/domain/reposiory/address_repo.dart';

class DeleteAddressUsecase extends UseCase<void, String> {
  final AddressRepo repo;

  DeleteAddressUsecase(this.repo);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repo.deleteAddress(params);
  }
}
