import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/features/address/data/models/address_model.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';
import 'package:food_ecommerce/features/cart/data/models/recipient_model.dart';
import 'package:food_ecommerce/features/cart/domain/entities/recipient.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_recipient_usecase.dart';
import 'package:food_ecommerce/features/store/data/models/product_model.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class CartDS {
  Future<void> addToCart(Product prod);
  Future<List<Product>> getCart();
  Future<void> removeFromCart(Product prod);
  Future<Address> addCartAddress(AddressParams address);
  Future<Address?> getCartAddress();
  Future<Recipient> addRecipient(ReciParams params);
  Future<Recipient?> getRecipient();
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

  @override
  Future<Address> addCartAddress(AddressParams address) async {
    final add = AddressModel(
      city: address.city,
      country: address.country,
      houseNumber: address.houseNumber,
      state: address.state,
      street: address.street,
    ).toJson();
    late Address cartAddress;
    try {
      await FirebaseFirestore.instance
          .collection('cart_address/')
          .doc(auth.currentUser!.uid)
          .set(add);

      await FirebaseFirestore.instance
          .collection('cart_address/')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        cartAddress = Address(
            city: value["city"],
            country: value["country"],
            houseNumber: value["house_number"],
            state: value["state"],
            street: value["street"],
            id: value["id"]);
      });
      return cartAddress;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Recipient> addRecipient(ReciParams params) async {
    final recipient =
        RecipientModel(name: params.name, phone: params.phone).toJson();
    late Recipient reci;
    try {
      await FirebaseFirestore.instance
          .collection('recipient/')
          .doc(auth.currentUser!.uid)
          .set(recipient);

      await FirebaseFirestore.instance
          .collection('recipient/')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        reci = Recipient(
          name: value["name"],
          phone: value["phone"],
        );
      });
      return reci;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Address?> getCartAddress() async {
    late Address? cartAddress;
    try {
      await FirebaseFirestore.instance
          .collection('cart_address/')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        cartAddress = Address(
            city: value["city"],
            country: value["country"],
            houseNumber: value["house_number"],
            state: value["state"],
            street: value["street"],
            id: value["id"]);
      });
      return cartAddress;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Recipient?> getRecipient() async {
    late Recipient? reci;
    try {
      await FirebaseFirestore.instance
          .collection('recipient/')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        reci = Recipient(
          name: value["name"],
          phone: value["phone"],
        );
      });
      return reci;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
