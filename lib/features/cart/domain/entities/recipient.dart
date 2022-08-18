import 'package:equatable/equatable.dart';

class Recipient extends Equatable {
  Recipient({
    required this.name,
    required this.phone,
  });

  final String name;
  final String phone;

  @override
  List<Object?> get props => [name, phone];

  Recipient copyWith({
    String? name,
    String? phone,
  }) {
    return Recipient(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
