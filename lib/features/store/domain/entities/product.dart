import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String subTitle;
  final String description;
  final String imageUrl;
  final double price;
  final int quantity;
  //final int? stars;

  const Product({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    //this.stars,
  });

  @override
  List<Object?> get props =>
      [id, title, subTitle, description, imageUrl, price, quantity];

  Product copyWith({
    String? id,
    String? title,
    String? subTitle,
    String? description,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
