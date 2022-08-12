import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/core/usecases/usecase.dart';
import 'package:food_ecommerce/features/auth/domain/entities/user_info.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/register_usecase.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/save_user_image_to_storage.dart';
import 'package:food_ecommerce/features/auth/domain/usecases/save_user_to_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  RegisterUsecase registerUsecase;
  LoginUsecase loginUsecase;
  LogoutUsecase logoutUsecase;
  SaveUserToDBUsecase saveUserToDBUsecase;
  GetUserDataUsecase getUserDataUsecase;
  SaveUserImageToStorageUsecase saveUserImageToStorageUsecase;

  AuthCubit({
    required this.registerUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.saveUserToDBUsecase,
    required this.getUserDataUsecase,
    required this.saveUserImageToStorageUsecase,
  }) : super(const AuthState());

  FirebaseAuth auth = FirebaseAuth.instance;

  User? user;
  bool get isUserLoggedIn => _checkLogin();
  UserData? userData;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res =
        await registerUsecase(RegisterParams(email: email, password: password));
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      user = r;
      emit(state.copyWith(isLoading: false, data: r, user: r));
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res =
        await loginUsecase(LoginParams(email: email, password: password));
    res.fold((l) {
      log(l.toString());
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      user = r;
      emit(state.copyWith(isLoading: false, data: r, user: r));
    });
  }

  Future<void> logout() async {
    await logoutUsecase.logout();
    user = null;
  }

  Future<void> saveUserToDB({
    required String email,
    required String phoneNumber,
    required String userName,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await saveUserToDBUsecase(
        UserParams(email: email, phoneNumber: phoneNumber, userName: userName));
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      emit(state.copyWith(isLoading: false, error: null));
    });
  }

  Future<void> getUserData() async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await getUserDataUsecase(NoParams());
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      userData = r;
      emit(state.copyWith(isLoading: false, data: r));
    });
  }

  Future<void> saveUserImageToStorage({
    required File imageFile,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await saveUserImageToStorageUsecase(imageFile);
    res.fold((l) {
      emit(state.copyWith(isLoading: false, error: l));
    }, (r) {
      emit(state.copyWith(isLoading: false, error: null));
    });
  }

  bool _checkLogin() {
    if (auth.currentUser != null) {
      log(auth.currentUser?.email ?? "user null");
      return true;
    } else {
      return false;
    }
  }
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) isLoading,
    Failure? error,
    dynamic data,
    User? user,
  }) = _AuthState;
}
