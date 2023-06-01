part of 'my_list_bloc.dart';

@immutable
abstract class MyListEvent {
  const MyListEvent();
}

class AddAndRemoveEvent extends MyListEvent {
  final MovieItem movie;

  const AddAndRemoveEvent({required this.movie});
}

class GetMovieItems extends MyListEvent {}
