import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';

class LogoutUsecase {
  final AuthRepo repo;

  LogoutUsecase(this.repo);

  Future<Either<Failure, void>> logout() async {
    return await repo.logout();
  }
}
