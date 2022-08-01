import 'package:dartz/dartz.dart';

import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> getProducts();
}
