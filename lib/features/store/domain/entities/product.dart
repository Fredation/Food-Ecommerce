import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String subTitle;
  final String description;
  final String imageUrl;
  final double price;
  //final int? stars;

  const Product({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.imageUrl,
    required this.price,
    //this.stars,
  });

  @override
  List<Object?> get props =>
      [id, title, subTitle, description, imageUrl, price];
}
