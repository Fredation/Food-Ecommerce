import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';

class SaveUserToDBUsecase extends UseCase<void, UserParams> {
  final AuthRepo repository;

  SaveUserToDBUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UserParams params) async {
    return await repository.saveUserToDB({
      'email': params.email.trim(),
      'phone_number': params.phoneNumber.trim(),
      'username': params.userName.trim(),
    });
  }
}

class UserParams {
  final String email;
  final String phoneNumber;
  final String userName;

  UserParams({
    required this.email,
    required this.phoneNumber,
    required this.userName,
  });
}
