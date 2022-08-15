import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/features/auth/domain/entities/user_info.dart';

abstract class AuthRepo {
  Future<Either<Failure, User?>> register(Map<String, dynamic> data);
  Future<Either<Failure, User?>> login(Map<String, dynamic> data);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> saveUserToDB(Map<String, dynamic> data);
  Future<Either<Failure, UserData>> getUserData();
  Future<Either<Failure, void>> saveUserImageToStorage(File data);
  Future<Either<Failure, void>> updateUserDB(Map<String, dynamic> data);
}
