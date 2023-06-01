import 'package:equatable/equatable.dart';

const keyId = 'id';
const keyTitle = 'title';
const keyPosterPath = 'poster_path';
const keyRating = 'rating';
const keyBackdropPath = 'backdrop_path';

class MovieItemEntity extends Equatable {
  final String id;
  final String posterPath;
  final String? backdropPath;
  final String title;
  final String rating;

  const MovieItemEntity(
      {required this.id,
      required this.posterPath,
      required this.title,
      required this.rating, this.backdropPath});

  MovieItemEntity.fromJson(Map<String, dynamic> json)
      : id = json[keyId],
        posterPath = json[keyPosterPath],
        title = json[keyTitle],
        rating = json[keyRating],
        backdropPath = json[keyRating];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[keyId] = id;
    map[keyPosterPath] = posterPath;
    map[keyBackdropPath] = backdropPath;
    map[keyTitle] = title;
    map[keyRating] = rating;
    return map;
  }

  @override
  List<Object?> get props => [id, posterPath, title, rating, backdropPath];
}
