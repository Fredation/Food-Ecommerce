import 'package:food_ecommerce/features/address/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    super.id,
    required super.houseNumber,
    required super.street,
    required super.city,
    required super.state,
    required super.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        houseNumber: json["house_number"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "house_number": houseNumber,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
      };
}
