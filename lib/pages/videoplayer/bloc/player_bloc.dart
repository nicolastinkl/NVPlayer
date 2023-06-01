import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final MoviesRepository repository;

  PlayerBloc({required this.repository}) : super(PlayerState.initial()) {
    on<FetchVideosEvent>(_onFetchVideosEvent);
    on<ChangeVideoEvent>(_onChangeVideoEvent);
  }

  Future<void> _onChangeVideoEvent(
    ChangeVideoEvent event,
    Emitter<PlayerState> emit,
  ) async {
    emit(state.copyWith(currentVideoKey: event.videoKey));
  }

  Future<void> _onFetchVideosEvent(
    FetchVideosEvent event,
    Emitter<PlayerState> emit,
  ) async {
    emit(state.copyWith(status: Status.pending));
    final responseState =
        await repository.getVideosByMovieId(movieId: event.movieId!);

    if (responseState is Success) {
      final data = responseState.successValue;
      emit(state.copyWith(status: Status.success, videos: data.videos));
    } else if (responseState is Fail) {
      emit(state.copyWith(status: Status.error));
    } else if (responseState is NoConnection) {
      emit(state.copyWith(status: Status.noConnection));
    } else {
      emit(state);
    }
  }
}
