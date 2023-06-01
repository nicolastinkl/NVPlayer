part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final List<GenreItem> genres;

  const MoviesState(this.genres);

  MoviesState.initial() : this([]);

  @override
  List<Object?> get props => [genres];
}
