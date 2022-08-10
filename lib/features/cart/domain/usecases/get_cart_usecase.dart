import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

class GetCartUsecase extends UseCase<List<Product>, NoParams> {
  final CartRepo repo;

  GetCartUsecase(this.repo);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repo.getCart();
  }
}
