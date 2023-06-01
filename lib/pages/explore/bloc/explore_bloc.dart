import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'explore_event.dart';

part 'explore_state.dart';

const defaultPageSize = 20;

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final MoviesRepository repository;
  StreamSubscription? _streamSubscription;

  ExploreBloc({required this.repository})
      : super(ExploreByQueryState.initial()) {
    on<FetchMoviesEvent>(_onFetchEvent, transformer: droppable());
    on<SearchMoviesEvent>(_onSearchEvent);
    on<ClearStateEvent>(_onClearStateEvent);
    on<FilterEvent>(_onFilterEvent);

    /// internal events
    on<_EmitResponseEvent>(_onEmitResponseEvent);
    on<_EmitErrorEvent>(_onEmitErrorEvent);
  }

  Future<void> _onFetchEvent(
      FetchMoviesEvent event, Emitter<ExploreState> emit) async {
    final currentState = state;

    if (currentState is ExploreByQueryState) {
      if (currentState.hasReached || currentState.status == Status.pending) {
        return;
      }

      emit(currentState.copyWith(status: Status.pending));

      _streamSubscription?.cancel();
      _streamSubscription = repository
          .getMoviesByQuery(
            page: currentState.page,
            query: currentState.query!,
          )
          .asStream()
          .listen((response) {
        add(_EmitResponseEvent(response));
      });
    } else if (currentState is ExploreByFilterState) {
      if (currentState.hasReached || currentState.status == Status.pending) {
        return;
      }

      emit(currentState.copyWith(status: Status.pending));

      final genre = currentState.filter?.genre?.value;
      final year = currentState.filter?.year?.value;
      final language = currentState.filter?.language?.value;

      _streamSubscription?.cancel();
      _streamSubscription = repository
          .discoverMovies(
            page: currentState.page,
            genreId: genre,
            year: year,
            language: language,
          )
          .asStream()
          .listen((response) {
        add(_EmitResponseEvent(response));
      });
    }
  }

  /// Function refreshes all [ExploreState] and cancelling [StreamSubscription]
  /// and recalls [FetchMoviesEvent] from UI scroll event with query.
  Future<void> _onSearchEvent(
      SearchMoviesEvent event, Emitter<ExploreState> emit) async {
    _streamSubscription?.cancel();

    emit(ExploreByQueryState.initial().copyWith(
      status: Status.pending,
      query: event.query,
    ));

    _streamSubscription = repository
        .getMoviesByQuery(page: 1, query: event.query)
        .asStream()
        .listen((response) {
      add(_EmitResponseEvent(response));
    });
  }

  /// Function refreshes all [ExploreState] and cancelling [StreamSubscription]
  /// and recalls [FetchMoviesEvent] from UI scroll event with query.
  Future<void> _onFilterEvent(
      FilterEvent event, Emitter<ExploreState> emit) async {
    _streamSubscription?.cancel();
    emit(ExploreByFilterState.initial().copyWith(
      status: Status.pending,
      filter: event.filter,
    ));

    ///TODO: need to implement.
  }

  Future<void> _onClearStateEvent(
      ClearStateEvent event, Emitter<ExploreState> emit) async {
    _streamSubscription?.cancel();
    emit(ExploreByQueryState.initial());
  }

  Future<void> _onEmitErrorEvent(
      _EmitErrorEvent event, Emitter<ExploreState> emit) async {
    final currentState = state;
    if (currentState is ExploreByFilterState) {
      emit(currentState.copyWith(status: Status.error));
    } else if (currentState is ExploreByQueryState) {
      emit(currentState.copyWith(status: Status.error));
    }
  }

  Future<void> _onEmitResponseEvent(
    _EmitResponseEvent event,
    Emitter<ExploreState> emit,
  ) async {
    final currentState = state;

    final responseState = event.responseState;

    if (responseState is Success) {
      final data = responseState.successValue;
      final movies = data.movies ?? [];
      final hasReached = movies.length < defaultPageSize;
      if (currentState is ExploreByFilterState) {
        final nextPage = (data.page ?? currentState.page) + 1;
        emit(currentState.copyWith(
            movies: movies,
            status: Status.success,
            page: nextPage,
            hasReached: hasReached));
      } else if (currentState is ExploreByQueryState) {
        final nextPage = (data.page ?? currentState.page) + 1;
        emit(currentState.copyWith(
            movies: movies,
            status: Status.success,
            page: nextPage,
            hasReached: hasReached));
      }
    } else if (responseState is Fail) {
      add(_EmitErrorEvent());
    } else if (responseState is NoConnection) {
      if (currentState is ExploreByFilterState) {
        emit(currentState.copyWith(status: Status.noConnection));
      } else if (currentState is ExploreByQueryState) {
        emit(currentState.copyWith(status: Status.noConnection));
      }
    } else {
      emit(state);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
