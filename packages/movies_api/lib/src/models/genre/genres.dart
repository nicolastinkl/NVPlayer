import 'package:equatable/equatable.dart';

import 'genre.dart';

class Genres extends Equatable {
  late List<Genre>? genres;

  Genres({required this.genres});

  Genres.fromJson(dynamic json) {
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres!.add(Genre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  List<Object?> get props => [genres];
}
