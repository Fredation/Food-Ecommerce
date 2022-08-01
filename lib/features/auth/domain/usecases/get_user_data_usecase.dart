import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/auth/domain/entities/user_info.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';

class GetUserDataUsecase extends UseCase<UserData, NoParams> {
  final AuthRepo repository;

  GetUserDataUsecase(this.repository);

  @override
  Future<Either<Failure, UserData>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
