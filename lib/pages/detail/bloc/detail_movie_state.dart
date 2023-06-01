part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movie;
  final bool isMarked;
  final List<MovieItem> movies;
  final List<VideoItem> videos;
  final List<CastItem> casts;
  final Status status;
  final Object? error;

  const DetailMovieState({
    required this.status,
    required this.isMarked,
    required this.videos,
    required this.movies,
    required this.casts,
    this.error,
    this.movie,
  });

  DetailMovieState.initialState()
      : this(
            status: Status.empty,
            movies: [],
            videos: [],
            casts: [],
            isMarked: false);

  DetailMovieState.empty()
      : this(
            status: Status.empty,
            movies: [],
            videos: [],
            casts: [],
            isMarked: false);

  DetailMovieState copyWith({
    Status? status,
    List<MovieItem>? movies,
    List<VideoItem>? videos,
    List<CastItem>? casts,
    bool? isMarked,
    Object? error,
    MovieDetail? movie,
  }) {
    return DetailMovieState(
      movie: movie ?? this.movie,
      videos: videos ?? this.videos,
      movies: movies ?? this.movies,
      casts: casts ?? this.casts,
      isMarked: isMarked ?? this.isMarked,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [movie, movies, isMarked, videos, casts, status, error];
}
