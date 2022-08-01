import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';

class LoginUsecase extends UseCase<User?, LoginParams> {
  final AuthRepo repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, User?>> call(LoginParams params) async {
    return await repository.login({
      "email": params.email,
      "password": params.password,
    });
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
