import 'package:equatable/equatable.dart';

class Address extends Equatable {
  Address({
    required this.houseNumber,
    this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
  });

  final String? id;
  final String houseNumber;
  final String street;
  final String city;
  final String state;
  final String country;

  @override
  List<Object?> get props => [houseNumber, street, city, state, country];

  Address copyWith({
    String? id,
    String? houseNumber,
    String? street,
    String? city,
    String? state,
    String? country,
  }) {
    return Address(
      id: id ?? this.id,
      houseNumber: houseNumber ?? this.houseNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }
}
