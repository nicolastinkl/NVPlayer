import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  final String name;
  final String id;
  final bool isActive;

  const GenreEntity({
    required this.name,
    required this.id,
    this.isActive = false,
  });

  GenreEntity changeFlag() {
    return GenreEntity(
      name: name,
      id: id,
      isActive: !isActive,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['is_active'] = isActive;
    return map;
  }

  @override
  List<Object?> get props => [id, name, isActive];
}
