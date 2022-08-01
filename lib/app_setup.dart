import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ecommerce/core/storage/storage.dart';
import 'package:firebase_core/firebase_core.dart';

class AppSetup {
  Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  Future initStorage(Storage storage) async {
    await storage.initStorage();
  }
}
