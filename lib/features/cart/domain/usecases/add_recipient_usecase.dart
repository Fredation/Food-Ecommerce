import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/cart/domain/entities/recipient.dart';
import 'package:food_ecommerce/features/cart/domain/repository/cart_repo.dart';

class AddRecipientUsecase extends UseCase<Recipient, ReciParams> {
  final CartRepo repo;

  AddRecipientUsecase(this.repo);

  @override
  Future<Either<Failure, Recipient>> call(ReciParams params) async {
    return await repo.addRecipient(params);
  }
}

class ReciParams {
  ReciParams({
    required this.name,
    required this.phone,
  });
  final String name;
  final String phone;
}
