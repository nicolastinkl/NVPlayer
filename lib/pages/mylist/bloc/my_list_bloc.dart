import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'my_list_event.dart';

part 'my_list_state.dart';

class MyListBloc extends Bloc<MyListEvent, MyListState> {
  final StorageRepository repository;

  late StreamSubscription<List<MovieItem>> _moviesStatusSubscription;

  MyListBloc({required this.repository}) : super(MyListState.initial()) {
    on<AddAndRemoveEvent>((event, emit) async {
      final hasMarked =
          await repository.checkWhetherIsMarkedOrNot(event.movie.id);
      if (hasMarked) {
        repository.deleteMovie(event.movie.id);
      } else {
        repository.saveMovies(event.movie);
      }
    });

    _moviesStatusSubscription = repository.getSavedMovies().listen((list) {
      if (list.isEmpty) {
        emit(state.copyWith(movies: [], status: Status.empty));
      } else {
        emit(state.copyWith(movies: list, status: Status.success));
      }
    });
  }

  @override
  Future<void> close() {
    _moviesStatusSubscription.cancel();
    return super.close();
  }
}
