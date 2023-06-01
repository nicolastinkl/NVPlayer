part of 'detail_movie_bloc.dart';

@immutable
abstract class DetailMovieEvent {
  const DetailMovieEvent();
}

class FetchedMovieEvent extends DetailMovieEvent {
  final String movieId;

  const FetchedMovieEvent({required this.movieId});
}

class BookmarkEvent extends DetailMovieEvent {
  final MovieItem item;

  const BookmarkEvent({required this.item});
}
