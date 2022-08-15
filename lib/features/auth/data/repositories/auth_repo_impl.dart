import 'dart:io';

import 'package:food_ecommerce/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/features/auth/data/datasources/auth_ds.dart';
import 'package:food_ecommerce/features/auth/domain/entities/user_info.dart';
import 'package:food_ecommerce/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDS authDS;

  AuthRepoImpl({required this.authDS});
  @override
  Future<Either<Failure, User?>> register(Map<String, dynamic> data) async {
    try {
      final res = await authDS.register(data);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> login(Map<String, dynamic> data) async {
    try {
      final res = await authDS.login(data);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final res = await authDS.logOut();
    return Right(res);
  }

  @override
  Future<Either<Failure, void>> saveUserToDB(Map<String, dynamic> data) async {
    try {
      final res = await authDS.saveUserToDB(data);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserData() async {
    try {
      final res = await authDS.getUserData();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserImageToStorage(File data) async {
    try {
      final res = await authDS.saveUserImageToStorage(data);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserDB(Map<String, dynamic> data) async {
    try {
      final res = await authDS.updateUserDB(data);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
