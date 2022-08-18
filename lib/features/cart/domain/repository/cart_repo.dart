import 'package:dartz/dartz.dart';
import 'package:food_ecommerce/core/error/failure.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/domain/usecases/create_address_usecase.dart';
import 'package:food_ecommerce/features/cart/domain/entities/recipient.dart';
import 'package:food_ecommerce/features/cart/domain/usecases/add_recipient_usecase.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart(Product prod);
  Future<Either<Failure, void>> removeFromCart(Product prod);
  Future<Either<Failure, List<Product>>> getCart();
  Future<Either<Failure, Address>> addCartAddress(AddressParams address);
  Future<Either<Failure, Recipient>> addRecipient(ReciParams params);
  Future<Either<Failure, Address?>> getCartAddress();
  Future<Either<Failure, Recipient?>> getRecipient();
}
