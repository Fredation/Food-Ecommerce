import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/favorite.dart';
import 'package:food_ecommerce/features/store/domain/repositories/product_repo.dart';

class ToggleFavUsecase extends UseCase<void, Favorite> {
  final ProductRepo repo;

  ToggleFavUsecase(this.repo);

  @override
  Future<Either<Failure, void>> call(Favorite params) async {
    return await repo.toggleFav(pid: params.id, isFavorite: params.isFavorite);
  }
}
