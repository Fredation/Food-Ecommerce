import 'package:food_ecommerce/features/store/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.description,
    required super.id,
    required super.imageUrl,
    required super.price,
    required super.subTitle,
    required super.title,
    required super.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        description: json["description"],
        id: json["id"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        subTitle: json["subTitle"],
        title: json["title"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "imageUrl": imageUrl,
        "price": price,
        "subTitle": subTitle,
        "title": title,
        "quantity": quantity,
      };
}
