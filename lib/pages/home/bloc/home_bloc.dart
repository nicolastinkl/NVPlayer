import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/navi/navilist.dart';
import 'package:movies_api/src/models/category/category.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository moviesRepository;

  HomeBloc({required this.moviesRepository}) : super(HomeState.initial()) {
    on<FetchUpcomingMoviesEvent>(_onFetchUpcomingMovies);
    on<FetchNowPlayingMoviesEvent>(_onFetchNowPlayingMovies);
    on<FetchPopularMoviesEvent>(_onFetchPopularMovies);
    on<FetchTopRatedMoviesEvent>(_onFetchTopRatedMovies);
    on<FetchTabDataByCategoryEvent>(_onFetchTabDataByCategory);
    // on<FetchAllCategorysEvent>(_onFetchAllCategorys);
  }

  Future<void> _onFetchTabDataByCategory(
    FetchTabDataByCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    final allcateState = state.tabDataByCateState;

    final allcateStateState = allcateState.copyWith(
        status: Status.pending, movies: allcateState.movies);
    print(event.categroy.navbarId);

    emit(state.copyWith(tabDataByCateState: allcateStateState));
    //{"navbar_id":"3256n4netmd","navbar_name":"\u63a8\u8350"}
    final responseState = await moviesRepository.getTabDataByCateResKey(
        navireskey: event.categroy.navbarId ?? "");

    if (responseState is Success) {
      final data = (responseState as Success<List<dynamic>>).data;
      final newallcateState =
          allcateState.copyWith(status: Status.success, movies: data);
      // 在 setState 方法中，我们使用 emit 方法来通知监听器委托，应该更新 UI。我们通过 copyWith 方法来创建一个新的状态对象，并将 allCategoryState 字段的值更新为新的状态。然后，我们使用 setState 方法来更新 UI，并将新的状态应用于 App 中。
      emit(state.copyWith(tabDataByCateState: newallcateState));
    } else if (responseState is Fail) {
      final newUpcomingMovState =
          allcateState.copyWith(status: Status.error, movies: []);
      emit(state.copyWith(tabDataByCateState: newUpcomingMovState));
    } else if (responseState is NoConnection) {
      final newUpcomingMovState =
          allcateState.copyWith(status: Status.noConnection);
      emit(state.copyWith(tabDataByCateState: newUpcomingMovState));
    } else {
      emit(state.copyWith(tabDataByCateState: allcateStateState));
    }
  }

/**
 * 获取所有分类数据事件
 
  Future<void> _onFetchAllCategorys(
    FetchAllCategorysEvent event,
    Emitter<HomeState> emit,
  ) async {
    final allcateState = state.allCategoryState;

    final allcateStateState = allcateState.copyWith(
        status: Status.pending, categorys: allcateState.categorys);

    emit(state.copyWith(allCategoryState: allcateStateState));

    final responseState = await moviesRepository.getCategorys();

    if (responseState is Success) {
      final data = (responseState as Success<List<Categroy_Home>>).data;
      final newallcateState =
          allcateState.copyWith(status: Status.success, categorys: data);
      // 在 setState 方法中，我们使用 emit 方法来通知监听器委托，应该更新 UI。我们通过 copyWith 方法来创建一个新的状态对象，并将 allCategoryState 字段的值更新为新的状态。然后，我们使用 setState 方法来更新 UI，并将新的状态应用于 App 中。
      emit(state.copyWith(allCategoryState: newallcateState));
    } else if (responseState is Fail) {
      final newUpcomingMovState =
          allcateState.copyWith(status: Status.error, categorys: []);
      emit(state.copyWith(allCategoryState: newUpcomingMovState));
    } else if (responseState is NoConnection) {
      final newUpcomingMovState =
          allcateState.copyWith(status: Status.noConnection);
      emit(state.copyWith(allCategoryState: newUpcomingMovState));
    } else {
      emit(state.copyWith(allCategoryState: allcateStateState));
    }
  }
*/

/**
 * Upcoming
 */
  Future<void> _onFetchUpcomingMovies(
    FetchUpcomingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final upcomingMovState = state.upcomingState;

    final newUpcomingMovState = upcomingMovState.copyWith(
      status: Status.pending,
      movies: upcomingMovState.movies,
    );

    emit(state.copyWith(upcomingState: newUpcomingMovState));

    final responseState = await moviesRepository.getAllNaviList(naviId: "home");

    if (responseState is Success) {
      final data = (responseState as Success<List<dynamic>>).data;
      final movies = data;

      // data.movies ?? [];
      final newUpcomingMovState = upcomingMovState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else if (responseState is Fail) {
      final newUpcomingMovState = upcomingMovState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else if (responseState is NoConnection) {
      final newUpcomingMovState =
          upcomingMovState.copyWith(status: Status.noConnection);
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else {
      emit(state.copyWith(upcomingState: upcomingMovState));
    }
  }

/**
 * Upcoming

  Future<void> _onFetchUpcomingMovies(
    FetchUpcomingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final upcomingMovState = state.upcomingState;

    final newUpcomingMovState = upcomingMovState.copyWith(
      status: Status.pending,
      movies: upcomingMovState.movies,
    );

    emit(state.copyWith(upcomingState: newUpcomingMovState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.UPCOMING,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newUpcomingMovState = upcomingMovState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else if (responseState is Fail) {
      final newUpcomingMovState = upcomingMovState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else if (responseState is NoConnection) {
      final newUpcomingMovState =
          upcomingMovState.copyWith(status: Status.noConnection);
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else {
      emit(state.copyWith(upcomingState: upcomingMovState));
    }
  } */

  /// Now Playing Movies
  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final nowPlayingMovsState = state.nowPlayingState;

    final newNowPlayingMosState = nowPlayingMovsState.copyWith(
      status: Status.pending,
      movies: nowPlayingMovsState.movies,
    );

    emit(state.copyWith(nowPlayingState: newNowPlayingMosState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.NOW_PLAYING,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newNowPlayingMosState = nowPlayingMovsState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(nowPlayingState: newNowPlayingMosState));
    } else if (responseState is Fail) {
      final newNowPlayingMosState = nowPlayingMovsState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(nowPlayingState: newNowPlayingMosState));
    } else if (responseState is NoConnection) {
      final newNowPlayingMosState =
          nowPlayingMovsState.copyWith(status: Status.noConnection);
      emit(state.copyWith(nowPlayingState: newNowPlayingMosState));
    } else {
      emit(state.copyWith(nowPlayingState: nowPlayingMovsState));
    }
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final topRatedMosState = state.topRatedState;

    final newTopRatedMovsState = topRatedMosState.copyWith(
      status: Status.pending,
      movies: topRatedMosState.movies,
    );

    emit(state.copyWith(topRatedState: newTopRatedMovsState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.TOP_RATED,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newTopRatedMovsState = topRatedMosState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(topRatedState: newTopRatedMovsState));
    } else if (responseState is Fail) {
      final newTopRatedMovsState = topRatedMosState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(topRatedState: newTopRatedMovsState));
    } else if (responseState is NoConnection) {
      final newTopRatedMovsState = topRatedMosState.copyWith(
        status: Status.noConnection,
      );
      emit(state.copyWith(topRatedState: newTopRatedMovsState));
    } else {
      emit(state.copyWith(topRatedState: topRatedMosState));
    }
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final popularMovsState = state.popularState;

    final newPopularMovsState = popularMovsState.copyWith(
      status: Status.pending,
      movies: popularMovsState.movies,
    );

    emit(state.copyWith(popularState: newPopularMovsState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.POPULAR,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newPopularMovsState = popularMovsState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(popularState: newPopularMovsState));
    } else if (responseState is Fail) {
      final newPopularMovsState = popularMovsState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(popularState: newPopularMovsState));
    } else if (responseState is NoConnection) {
      final newPopularMovsState = popularMovsState.copyWith(
        status: Status.noConnection,
      );
      emit(state.copyWith(popularState: newPopularMovsState));
    } else {
      emit(state.copyWith(popularState: popularMovsState));
    }
  }
}
