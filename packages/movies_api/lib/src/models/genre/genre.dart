import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  Genre.fromJson(dynamic json)
      : id = json['id'].toString(),
        name = json['name'].toString();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  @override
  List<Object?> get props => [id, name];
}
