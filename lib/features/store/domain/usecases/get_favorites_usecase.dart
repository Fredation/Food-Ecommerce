import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/favorite.dart';
import 'package:food_ecommerce/features/store/domain/repositories/product_repo.dart';

class GetFavoriteUsecase extends UseCase<List<Favorite>, NoParams> {
  final ProductRepo repo;

  GetFavoriteUsecase(this.repo);

  @override
  Future<Either<Failure, List<Favorite>>> call(NoParams params) async {
    return await repo.getFavorites();
  }
}
