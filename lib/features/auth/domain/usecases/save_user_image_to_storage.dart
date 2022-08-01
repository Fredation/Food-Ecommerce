import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';

class SaveUserImageToStorageUsecase extends UseCase<void, File> {
  final AuthRepo repository;

  SaveUserImageToStorageUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(File params) async {
    return await repository.saveUserImageToStorage(params);
  }
}
