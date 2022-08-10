import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ecommerce/features/address/data/models/address_model.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';

abstract class AddressDS {
  Future<void> createAddress(AddressParams address);
  Future<List<Address>> getAddresses();
  Future<void> deleteAddress(aid);
}

class AddressDSImpl implements AddressDS {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> createAddress(AddressParams address) async {
    final add = AddressModel(
      city: address.city,
      country: address.country,
      houseNumber: address.houseNumber,
      state: address.state,
      street: address.street,
    ).toJson();
    log(add.toString());
    try {
      await FirebaseFirestore.instance
          .collection('user_addresses/')
          .doc(auth.currentUser!.uid)
          .collection('/addresses')
          .doc()
          .set(add);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Address>> getAddresses() async {
    try {
      final List<Address> addresses = [];
      await FirebaseFirestore.instance
          .collection('user_addresses/')
          .doc(auth.currentUser!.uid)
          .collection('/addresses')
          .get()
          .then((data) {
        log(data.docs.length.toString());
        for (var addData in data.docs) {
          addresses.add(Address(
            id: addData.id,
            city: addData["city"],
            country: addData["country"],
            houseNumber: addData["house_number"],
            state: addData["state"],
            street: addData["street"],
          ));
        }
      });
      log("loaded" + addresses.toString());
      return addresses;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress(aid) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_addresses/')
          .doc(auth.currentUser!.uid)
          .collection('/addresses')
          .doc(aid)
          .delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
