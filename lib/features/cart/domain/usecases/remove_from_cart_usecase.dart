import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

class RemoveFromCartUsecase extends UseCase<void, Product> {
  final CartRepo repo;

  RemoveFromCartUsecase(this.repo);

  @override
  Future<Either<Failure, void>> call(Product params) async {
    return await repo.removeFromCart(params);
  }
}
