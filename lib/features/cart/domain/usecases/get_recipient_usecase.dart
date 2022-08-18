import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/cart/domain/entities/recipient.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';

class GetRecipientUsecase extends UseCase<Recipient?, NoParams> {
  final CartRepo repo;

  GetRecipientUsecase(this.repo);

  @override
  Future<Either<Failure, Recipient?>> call(NoParams params) async {
    return await repo.getRecipient();
  }
}
