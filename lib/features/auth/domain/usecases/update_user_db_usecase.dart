import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/save_user_to_db.dart';

class UpdateUserDBUsecase extends UseCase<void, UserParams> {
  final AuthRepo repository;

  UpdateUserDBUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UserParams params) async {
    return await repository.updateUserDB({
      'email': params.email.trim(),
      'phone_number': params.phoneNumber.trim(),
      'username': params.userName.trim(),
      "image_url": params.imageUrl,
    });
  }
}
