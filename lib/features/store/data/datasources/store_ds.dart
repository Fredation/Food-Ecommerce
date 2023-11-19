import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/core/network/api.dart';
import 'package:food_ecommerce/core/storage/storage.dart';
import 'package:food_ecommerce/features/store/data/models/favorite_model.dart';
import 'package:food_ecommerce/features/store/domain/entities/favorite.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class StoreDS {
  Future<List<Product>> getProducts();
  Future<void> toggleFav({required String pid, required bool isFavorite});
  Future<List<Favorite>> getFavorites();
}

class StoreDSImpl implements StoreDS {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Storage storage;
  StoreDSImpl({required this.storage});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final List<Product> loadedProducts = [];
      await FirebaseFirestore.instance
          .collection('all_products/')
          .get()
          .then((data) {
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
      return loadedProducts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> toggleFav(
      {required String pid, required bool isFavorite}) async {
    final fav = FavoriteModel(id: pid, isFavorite: isFavorite).toJson();
    try {
      isFavorite == true
          ? await FirebaseFirestore.instance
              .collection('favorites/')
              .doc(auth.currentUser!.uid)
              .collection('/items')
              .doc(pid)
              .set(fav)
          : await FirebaseFirestore.instance
              .collection('favorites/')
              .doc(auth.currentUser!.uid)
              .collection('/items')
              .doc(pid)
              .delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Favorite>> getFavorites() async {
    try {
      final List<Favorite> loadedFavorites = [];
      await FirebaseFirestore.instance
          .collection('favorites/')
          .doc(auth.currentUser!.uid)
          .collection('/items')
          .get()
          .then((data) {
        for (var favData in data.docs) {
          loadedFavorites.add(Favorite(
            id: favData.id,
            isFavorite: favData["favorite"],
          ));
        }
      });
      return loadedFavorites;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
