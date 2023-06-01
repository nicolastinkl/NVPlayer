import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:rxdart/rxdart.dart';

class FilterState extends Equatable {
  final List<GenreItem> genres;
  final Status status;

  const FilterState(this.genres, this.status);

  FilterState.loading() : this([], Status.pending);

  const FilterState.success(List<GenreItem> genres)
      : this(genres, Status.success);

  FilterState.fail() : this([], Status.error);

  FilterState.noConnection() : this([], Status.noConnection);

  @override
  List<Object?> get props => [genres, status];
}

class FilterViewModel {
  final MoviesRepository repository;

  FilterViewModel(MoviesRepository? moviesRepository)
      : repository = moviesRepository ?? MoviesRepository();

  StreamSubscription? _streamSubscription;

  final _genresStreamController =
      BehaviorSubject<FilterState>.seeded(FilterState.loading());

  Stream<FilterState> get getGenresStream => _genresStreamController;

  Future<void> loadGenres() async {
    _streamSubscription?.cancel();
    _streamSubscription =
        repository.getGenres().asStream().listen((responseState) {
      if (responseState is Success) {
        _genresStreamController.sink
            .add(FilterState.success(responseState.successValue));
      } else if (responseState is Fail) {
        _genresStreamController.sink.add(FilterState.fail());
      } else if (responseState is NoConnection) {
        _genresStreamController.sink.add(FilterState.noConnection());
      } else {
        _genresStreamController.sink.add(FilterState.fail());
      }
    });
  }

  void close() {
    _streamSubscription?.cancel();
    _genresStreamController.close();
  }
}
