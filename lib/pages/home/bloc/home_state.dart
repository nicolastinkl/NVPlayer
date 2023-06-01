part of 'home_bloc.dart';

class HomeState extends Equatable {
  final UpcomingMoviesState upcomingState;
  final NowPlayingMoviesState nowPlayingState;
  final PopularMoviesState popularState;
  final TopRatedMoviesState topRatedState;
  final AllTabDatabyCategoryState tabDataByCateState;
  // final AllCategoryState allCategoryState;

  const HomeState({
    required this.nowPlayingState,
    required this.popularState,
    required this.topRatedState,
    required this.upcomingState,
    required this.tabDataByCateState,
    // required this.allCategoryState,
  });

  HomeState.initial()
      : this(
          upcomingState: UpcomingMoviesState.initial(),
          nowPlayingState: NowPlayingMoviesState.initial(),
          popularState: PopularMoviesState.initial(),
          topRatedState: TopRatedMoviesState.initial(),
          tabDataByCateState: AllTabDatabyCategoryState.initial(),
          // allCategoryState: AllCategoryState.initial()
        );

  HomeState copyWith({
    UpcomingMoviesState? upcomingState,
    NowPlayingMoviesState? nowPlayingState,
    PopularMoviesState? popularState,
    TopRatedMoviesState? topRatedState,
    AllTabDatabyCategoryState? tabDataByCateState,
    // AllCategoryState? allCategoryState,
  }) {
    return HomeState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularState: popularState ?? this.popularState,
      topRatedState: topRatedState ?? this.topRatedState,
      upcomingState: upcomingState ?? this.upcomingState,
      tabDataByCateState: tabDataByCateState ?? this.tabDataByCateState,
      // allCategoryState: allCategoryState ?? this.allCategoryState,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingState,
        popularState,
        topRatedState,
        upcomingState,
        tabDataByCateState,
        // allCategoryState,
      ];
}

class AllTabDatabyCategoryState extends Equatable {
  final Status status;
  final List<dynamic> movies;
  const AllTabDatabyCategoryState(this.status, this.movies);
  AllTabDatabyCategoryState.initial() : this(Status.empty, []);
  AllTabDatabyCategoryState copyWith({Status? status, List<dynamic>? movies}) {
    return AllTabDatabyCategoryState(
        status ?? this.status, movies ?? this.movies);
  }

  @override
  List<Object?> get props => [status, movies];
}

class UpcomingMoviesState extends Equatable {
  final Status status;
  final List<dynamic> movies;
  const UpcomingMoviesState(this.status, this.movies);
  UpcomingMoviesState.initial() : this(Status.empty, []);
  UpcomingMoviesState copyWith({Status? status, List<dynamic>? movies}) {
    return UpcomingMoviesState(status ?? this.status, movies ?? this.movies);
  }

  @override
  List<Object?> get props => [status, movies];
}

class NowPlayingMoviesState extends Equatable {
  final Status status;
  final List<MovieItem> movies;
  const NowPlayingMoviesState(this.status, this.movies);
  NowPlayingMoviesState.initial() : this(Status.empty, []);
  NowPlayingMoviesState copyWith({Status? status, List<MovieItem>? movies}) {
    return NowPlayingMoviesState(status ?? this.status, movies ?? this.movies);
  }

  @override
  List<Object?> get props => [status, movies];
}

class PopularMoviesState extends Equatable {
  final Status status;
  final List<MovieItem> movies;
  const PopularMoviesState(this.status, this.movies);
  PopularMoviesState.initial() : this(Status.empty, []);
  PopularMoviesState copyWith({Status? status, List<MovieItem>? movies}) {
    return PopularMoviesState(status ?? this.status, movies ?? this.movies);
  }

  @override
  List<Object?> get props => [status, movies];
}

class TopRatedMoviesState extends Equatable {
  final Status status;
  final List<MovieItem> movies;
  const TopRatedMoviesState(this.status, this.movies);
  TopRatedMoviesState.initial() : this(Status.empty, []);
  TopRatedMoviesState copyWith({Status? status, List<MovieItem>? movies}) {
    return TopRatedMoviesState(status ?? this.status, movies ?? this.movies);
  }

  @override
  List<Object?> get props => [status, movies];
}

///所有类别State
class AllCategoryState extends Equatable {
  final Status status;
  final List<dynamic> categorys;
  const AllCategoryState(this.status, this.categorys);
  AllCategoryState.initial() : this(Status.empty, []);
  AllCategoryState copyWith({Status? status, List<dynamic>? categorys}) {
    return AllCategoryState(status ?? this.status, categorys ?? this.categorys);
  }

  @override
  List<Object?> get props => [status, categorys];
}
