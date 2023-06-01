part of 'explore_bloc.dart';

@immutable
abstract class ExploreState extends Equatable {}

class ExploreByQueryState extends ExploreState {
  final String? query;
  final List<MovieItem> movies;
  final int page;
  final bool hasReached;
  final Status status;

  ExploreByQueryState(
      {required this.page,
      required this.hasReached,
      this.query,
      required this.movies,
      required this.status});

  ExploreByQueryState.initial()
      : this(
            page: 1,
            hasReached: false,
            query: null,
            movies: [],
            status: Status.success);

  ExploreByQueryState copyWith({
    String? query,
    List<MovieItem>? movies,
    int? page,
    bool? hasReached,
    Status? status,
  }) {
    return ExploreByQueryState(
        query: query ?? this.query,
        page: page ?? this.page,
        hasReached: hasReached ?? this.hasReached,
        movies: [...this.movies, ...movies ?? []],
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [query, page, hasReached, movies, status];
}

class ExploreByFilterState extends ExploreState {
  final Filter? filter;
  final List<MovieItem> movies;
  final int page;
  final bool hasReached;
  final Status status;

  ExploreByFilterState(
      {required this.page,
      required this.hasReached,
      this.filter,
      required this.movies,
      required this.status});

  ExploreByFilterState.initial()
      : this(
            page: 1,
            hasReached: false,
            filter: null,
            movies: [],
            status: Status.success);

  ExploreByFilterState copyWith({
    Filter? filter,
    List<MovieItem>? movies,
    int? page,
    bool? hasReached,
    Status? status,
  }) {
    return ExploreByFilterState(
        filter: filter ?? this.filter,
        page: page ?? this.page,
        hasReached: hasReached ?? this.hasReached,
        movies: [...this.movies, ...movies ?? []],
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [filter, page, hasReached, movies, status];
}

class Filter extends Equatable {
  final FilterObject? genre;
  final FilterObject? language;
  final FilterObject? year;

  const Filter({this.genre, this.language, this.year});

  Filter copyWith({
    FilterObject? genre,
    FilterObject? language,
    FilterObject? year,
  }) {
    return Filter(
      genre: genre ?? this.genre,
      language: language ?? this.language,
      year: year ?? this.year,
    );
  }

  @override
  List<Object?> get props => [genre, language, year];
}

class FilterObject extends Equatable {
  final String name;
  final String value;

  const FilterObject(this.name, this.value);

  @override
  List<Object?> get props => [name, value];
}
