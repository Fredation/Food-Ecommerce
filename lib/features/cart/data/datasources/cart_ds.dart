import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/features/store/data/models/product_model.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class CartDS {
  Future<void> addToCart(Product prod);
  Future<List<Product>> getCart();
  Future<void> removeFromCart(Product prod);
}

class CartDSImpl implements CartDS {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> addToCart(Product prod) async {
    final product = ProductModel(
      description: prod.description,
      id: prod.id,
      imageUrl: prod.imageUrl,
      price: prod.price,
      subTitle: prod.subTitle,
      title: prod.title,
      quantity: prod.quantity,
    ).toJson();
    log(product.toString());
    try {
      await FirebaseFirestore.instance
          .collection('cart_products/')
          .doc(auth.currentUser!.uid)
          .collection('/items')
          .doc(prod.id)
          .set(product);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Product>> getCart() async {
    try {
      final List<Product> loadedProducts = [];
      await FirebaseFirestore.instance
          .collection('cart_products/')
          .doc(auth.currentUser!.uid)
          .collection('/items')
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

  @override
  Future<void> removeFromCart(Product prod) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart_products/')
          .doc(auth.currentUser!.uid)
          .collection('/items')
          .doc(prod.id)
          .delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
