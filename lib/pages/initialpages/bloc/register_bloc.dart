import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final StorageRepository storageRepository;
  final MoviesRepository moviesRepository;

  StreamSubscription<List<GenreItem>>? _streamSubscription;

  RegisterBloc({
    required this.authRepository,
    required this.storageRepository,
    required this.moviesRepository,
  }) : super(RegisterState.initial()) {
    on<FetchGenresEvent>(_onFetchGenresEvent);
    on<FinishRegisterEvent>(_onFinishRegisterEvent);
    on<ChangeFlagEvent>(_onChangeFlagEvent);
    on<_RefreshEvent>(_onRefreshEvent);

    _streamSubscription = storageRepository.getSavedGenres().listen((genres) {
      add(_RefreshEvent(genres));
    });
  }

  Future<void> _onRefreshEvent(
    _RefreshEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(genres: event.genres));
  }

  Future<void> _onFetchGenresEvent(
    FetchGenresEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: Status.pending));
    final responseState = await moviesRepository.getGenres();
    if (responseState is Success) {
      final data = responseState.successValue;
      await storageRepository.saveListOfGenres({...data});
      emit(state.copyWith(status: Status.success));
    } else if (responseState is Fail) {
      final error = responseState.errorValue;
      emit(state.copyWith(status: Status.error, error: error));
    } else if (responseState is NoConnection) {
      emit(state.copyWith(status: Status.noConnection, error: null));
    } else {
      emit(state);
    }
  }

  Future<void> _onChangeFlagEvent(
      ChangeFlagEvent event, Emitter<RegisterState> emit) async {
    storageRepository.changeGenreFlag(event.genre);
  }

  Future<void> _onFinishRegisterEvent(
      RegisterEvent event, Emitter<RegisterState> state) async {
    authRepository.login();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
