part of 'explore_bloc.dart';

@immutable
abstract class ExploreEvent {}

@immutable
class FetchMoviesEvent extends ExploreEvent {}

@immutable
class FilterEvent extends ExploreEvent {
  FilterEvent(this.filter);

  final Filter filter;
}

@immutable
class SearchMoviesEvent extends ExploreEvent {
  SearchMoviesEvent(this.query);

  final String query;
}

@immutable
class ClearStateEvent extends ExploreEvent {}

/// Internal event from network
@immutable
class _EmitResponseEvent extends ExploreEvent {
  _EmitResponseEvent(this.responseState);
  final ResponseState<MoviesList> responseState;
}

/// Internal event from network
@immutable
class _EmitErrorEvent extends ExploreEvent {
  _EmitErrorEvent({this.error});

  final Object? error;
}
