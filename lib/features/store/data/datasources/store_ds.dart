import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/core/network/api.dart';
import 'package:food_ecommerce/core/storage/storage.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class StoreDS {
  Future<List<Product>> getProducts();
}

class StoreDSImpl implements StoreDS {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Storage storage;
  final Api api;
  StoreDSImpl({required this.storage, required this.api});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final List<Product> loadedProducts = [];
      await FirebaseFirestore.instance
          .collection('all_products/')
          .get()
          .then((data) {
        log(data.docs.length.toString());
        for (var prodData in data.docs) {
          loadedProducts.add(Product(
            id: prodData.id,
            title: prodData["title"],
            subTitle: prodData["subTitle"],
            description: prodData["description"],
            imageUrl: prodData["imageUrl"],
            price: double.parse(prodData["price"].toString()),
            quantity: int.parse(prodData["quantity"].toString()),
          ));
        }
      });
      log("loaded" + loadedProducts.toString());
      return loadedProducts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
