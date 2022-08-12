import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String id;
  final bool isFavorite;

  const Favorite({
    required this.id,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [id, isFavorite];

  Favorite copyWith({
    String? id,
    bool? isFavorite,
  }) {
    return Favorite(
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
