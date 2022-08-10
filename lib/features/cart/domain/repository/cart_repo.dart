import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart(Product prod);
  Future<Either<Failure, void>> removeFromCart(Product prod);
  Future<Either<Failure, List<Product>>> getCart();
}
