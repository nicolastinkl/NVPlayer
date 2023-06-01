import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'detail_movie_state.dart';

part 'detail_movie_event.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final MoviesRepository moviesRepository;
  final StorageRepository storageRepository;

  DetailMovieBloc({
    required this.moviesRepository,
    required this.storageRepository,
  }) : super(DetailMovieState.initialState()) {
    on<FetchedMovieEvent>(_onFetchMovieDetailEvent);
    on<BookmarkEvent>(_onBookmarkEvent);
  }

  Future<void> _onFetchMovieDetailEvent(
    FetchedMovieEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    emit(state.copyWith(status: Status.pending));
    final responseState =
        await moviesRepository.getMovieDetailNew(event.movieId);
    // final responseState = await moviesRepository.getMovieDetail(event.movieId);

    if (responseState is Success) {
      final dataDetailMovie = (responseState as Success<MovieDetail>).data;

      final similarMovResState = await moviesRepository.getSimilarMovies(
        movieId: event.movieId,
      );
      final isMarked = await storageRepository.checkWhetherIsMarkedOrNot(
        event.movieId,
      );
      final videosResState = await moviesRepository.getVideosByMovieId(
        movieId: event.movieId,
      );
      final castsResState = await moviesRepository.getCastsById(
        movieId: event.movieId,
      );
      final movies = similarMovResState.getValueOrNull()?.movies ?? [];
      final videos = videosResState.getValueOrNull()?.videos ?? [];
      final casts = castsResState.getValueOrNull() ?? [];
      emit(state.copyWith(
        status: Status.success,
        movie: dataDetailMovie,
        videos: videos,
        movies: movies,
        casts: casts,
        isMarked: isMarked,
      ));
    } else if (responseState is Fail) {
      final error = (responseState as Fail).error;
      emit(state.copyWith(status: Status.error, error: error));
    } else if (responseState is NoConnection) {
      emit(state.copyWith(status: Status.noConnection));
    } else {
      emit(DetailMovieState.empty());
    }
  }

  Future<void> _onBookmarkEvent(
    BookmarkEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    if (state.isMarked) {
      storageRepository.deleteMovie(event.item.id);
      emit(state.copyWith(isMarked: false));
    } else {
      storageRepository.saveMovies(event.item);
      emit(state.copyWith(isMarked: true));
    }
  }
}
