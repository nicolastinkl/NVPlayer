part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class GetActiveGenres extends MoviesEvent {}
