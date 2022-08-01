import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';

class RegisterUsecase extends UseCase<User?, RegisterParams> {
  final AuthRepo repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, User?>> call(RegisterParams params) async {
    return await repository.register({
      "email": params.email,
      "password": params.password,
    });
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({
    required this.email,
    required this.password,
  });
}
