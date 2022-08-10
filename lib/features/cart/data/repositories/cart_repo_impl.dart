import 'package:food_ecommerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/features/cart/data/datasources/cart_ds.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

class CartRepoImpl implements CartRepo {
  CartDS cartDS;
  CartRepoImpl({required this.cartDS});

  @override
  Future<Either<Failure, void>> addToCart(Product prod) async {
    try {
      final res = await cartDS.addToCart(prod);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCart() async {
    try {
      final res = await cartDS.getCart();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(Product prod) async {
    try {
      final res = await cartDS.removeFromCart(prod);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
