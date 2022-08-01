import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_ecommerce/core/storage/storage.dart';
import 'package:food_ecommerce/features/auth/domain/entities/user_info.dart';

abstract class AuthDS {
  Future<User?> register(data);
  Future<User?> login(data);
  Future<void> logOut();
  Future<void> saveUserToDB(data);
  Future<UserData> getUserData();
  Future<void> saveUserImageToStorage(data);
}

class AuthDSImpl implements AuthDS {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Storage storage;
  AuthDSImpl({required this.storage});

  @override
  Future<User?> register(data) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(
          email: data["email"], password: data["password"]);
      log(response.toString());
      if (response.user?.uid != null) {
        await storage.saveToken(value: response.user!.uid);
        return response.user;
      } else {
        throw Exception();
      }
    } on DioError {
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<User?> login(data) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
          email: data["email"], password: data["password"]);
      log(response.toString());
      if (response.user?.uid != null) {
        await storage.saveToken(value: response.user!.uid);
        return response.user;
      } else {
        throw Exception();
      }
    } on DioError {
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await auth.signOut();
    } on DioError {
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> saveUserToDB(data) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserData> getUserData() async {
    try {
      late UserData userData;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        userData = UserData(
            email: value['email'],
            phoneNumber: value['phone_number'],
            userName: value['username']);
      });

      return userData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserImageToStorage(data) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(auth.currentUser!.uid + '.jpg');
      await ref.putFile(data);
    } catch (e) {
      rethrow;
    }
  }
}

// class AuthController extends GetxController {
//   late Rx<User?> _user;
//   FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   void onReady() {
//     super.onReady();
//     _user = Rx<User?>(auth.currentUser);
//     //_user.bindStream(auth.userChanges());
//     _user.bindStream(auth.authStateChanges());
//     ever(_user, _initialScreen);
//   }

//   _initialScreen(User? user) {
//     if (user == null) {
//       return Get.offAll(() => LoginScreen());
//     } else {
//       return Get.offAll(() => const HomeScreen());
//     }
//   }

  // Future<void> register(var formData) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //         email: formData["email"], password: formData["password"]);
  //   } catch (e) {
  //     Get.snackbar(
  //       "error signing up",
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  // Future<void> login(var formData) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(
  //         email: formData["email"], password: formData["password"]);
  //     //print("login response" + _userCredential.credential.toString());
  //   } catch (e) {
  //     Get.snackbar(
  //       "error signing in",
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  // Future<void> logOut() async {
  //   try {
  //     await auth.signOut();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
//}
