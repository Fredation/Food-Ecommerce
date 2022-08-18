import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';

class GetCartAddressUsecase extends UseCase<Address?, NoParams> {
  final CartRepo repo;

  GetCartAddressUsecase(this.repo);

  @override
  Future<Either<Failure, Address?>> call(NoParams params) async {
    return await repo.getCartAddress();
  }
}
