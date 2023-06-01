import 'package:equatable/equatable.dart';

import 'movie_item.dart';

class MoviesList extends Equatable {
  final List<MovieItem>? movies;
  final int? page;

  MoviesList({
    this.movies,
    this.page,
  });

  @override
  String toString() => {
        'movies': movies,
        'page': page,
      }.toString();

  @override
  List<Object?> get props => [movies, page];
}
