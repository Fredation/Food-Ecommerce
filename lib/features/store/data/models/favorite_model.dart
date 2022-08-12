import 'package:food_ecommerce/features/store/domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  const FavoriteModel({
    required super.isFavorite,
    required super.id,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        isFavorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "favorite": isFavorite,
      };
}
