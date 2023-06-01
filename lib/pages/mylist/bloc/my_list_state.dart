part of 'my_list_bloc.dart';

class MyListState extends Equatable {
  final List<MovieItem> movies;
  final Status status;
  final MovieItem? temporary;

  const MyListState(
      {required this.movies, required this.status, this.temporary});

  MyListState.initial()
      : this(movies: [], status: Status.empty, temporary: null);

  MyListState copyWith({
    Status? status,
    List<MovieItem>? movies,
    MovieItem? temporary,
  }) {
    return MyListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      temporary: temporary ?? this.temporary,
    );
  }

  @override
  List<Object?> get props => [movies, temporary, status];
}
