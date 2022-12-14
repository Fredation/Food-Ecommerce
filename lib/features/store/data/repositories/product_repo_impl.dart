import 'package:food_ecommerce/features/store/data/datasources/store_ds.dart';
import 'package:food_ecommerce/features/store/domain/entities/favorite.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/features/store/domain/repositories/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final StoreDS storeDS;

  ProductRepoImpl({required this.storeDS});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final res = await storeDS.getProducts();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Favorite>>> getFavorites() async {
    try {
      final res = await storeDS.getFavorites();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFav(
      {required String pid, required bool isFavorite}) async {
    try {
      final res = await storeDS.toggleFav(pid: pid, isFavorite: isFavorite);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
