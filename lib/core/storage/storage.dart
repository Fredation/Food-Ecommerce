library storage;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract class Storage {
  Future<void> clearAllStorage();
  Future<bool> containsData({required String key});
  Future<void> delete({required String key});
  Future<dynamic> getData({required String key});
  Future<String?> getToken();
  Future<dynamic> getUser();
  Future<String?> getUserType();
  Future<void> initStorage();
  Future<void> saveToken({required String value});
  Future<void> saveUser({dynamic data});
  Future<void> saveUserType({required String data});
  Future<void> storeData({required String key, dynamic value});
}

class StorageImpl implements Storage {
  final String userBox = "userBox";
  final String tokenKey = "tokenkey";
  final String userKey = "userkey";
  final String userTypeKey = "userTypekey";
  final String deviceBox = "device";

  @override
  Future<void> clearAllStorage() async {
    await Hive.deleteBoxFromDisk(deviceBox);
    await Hive.deleteBoxFromDisk(userBox);
  }

  @override
  Future<bool> containsData({required String key}) async {
    final openBox = await Hive.openBox(deviceBox);
    final contains = openBox.containsKey(key);

    await openBox.close();

    return contains;
  }

  @override
  Future<void> delete({required String key}) async {
    final openBox = await Hive.openBox(deviceBox);
    await openBox.delete(key);
    await openBox.close();
  }

  @override
  Future getData({required String key}) async {
    final openBox = await Hive.openBox(deviceBox);
    final value = await openBox.get(key);
    await openBox.close();
    return value;
  }

  @override
  Future<String?> getToken() async {
    final openBox = await Hive.openBox(userBox);
    final value = await openBox.get(tokenKey);
    await openBox.close();
    return value;
  }

  @override
  Future getUser() async {
    final openBox = await Hive.openBox(userBox);
    final value = await openBox.get(userKey);
    await openBox.close();
    return value;
  }

  @override
  Future<String?> getUserType() async {
    final openBox = await Hive.openBox(userBox);
    final value = await openBox.get(userTypeKey);
    await openBox.close();
    return value;
  }

  @override
  Future initStorage() async {
    if (kIsWeb) return;

    final appDocDirectory = await getApplicationDocumentsDirectory();

    Hive.init(appDocDirectory.path);
  }

  @override
  Future<void> saveToken({required String value}) async {
    final openBox = await Hive.openBox(userBox);
    await openBox.put(tokenKey, value);
    await openBox.close();
  }

  @override
  Future<void> saveUser({data}) async {
    final openBox = await Hive.openBox(userBox);
    await openBox.put(userKey, data);
    await openBox.close();
  }

  @override
  Future<void> saveUserType({required String data}) async {
    final openBox = await Hive.openBox(userBox);
    await openBox.put(userTypeKey, data);
    await openBox.close();
  }

  @override
  Future<void> storeData({required String key, dynamic value}) async {
    final openBox = await Hive.openBox(deviceBox);
    await openBox.put(key, value);
    await openBox.close();
  }
}
