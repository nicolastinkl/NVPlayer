import 'package:equatable/equatable.dart';

class GenreItem extends Equatable {
  final String id;
  final String name;
  final bool isActive;

  GenreItem({
    required this.id,
    required this.name,
    this.isActive = false,
  });

  @override
  List<Object?> get props => [id, name, isActive];
}
