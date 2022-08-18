import 'package:food_ecommerce/features/cart/domain/entities/recipient.dart';

class RecipientModel extends Recipient {
  RecipientModel({
    required super.name,
    required super.phone,
  });

  factory RecipientModel.fromJson(Map<String, dynamic> json) => RecipientModel(
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };
}
