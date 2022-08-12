import 'package:dartz/dartz.dart';

import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/features/store/domain/entities/favorite.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Favorite>>> getFavorites();
  Future<Either<Failure, void>> toggleFav(
      {required String pid, required bool isFavorite});
}
