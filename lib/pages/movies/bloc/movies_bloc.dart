import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final StorageRepository _repository;

  MoviesBloc({required StorageRepository repository})
      : _repository = repository,
        super(MoviesState.initial()) {
    on<GetActiveGenres>((event, emit) async {
      final activeGenres = _repository.getSavedGenres();
      // emit(MoviesState());
    });
  }
}
