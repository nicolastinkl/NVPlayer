part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

///获取将来 + 根据Navi ID获取数据
class FetchUpcomingMoviesEvent extends HomeEvent {}

//根据类别来获取所有tab单项的数据
class FetchTabDataByCategoryEvent extends HomeEvent {
  final Categroy_Home categroy;

  FetchTabDataByCategoryEvent({required this.categroy});
  // const FetchTabDataByCategoryEvent({required this.categroyname});
}

///获取正在播放
class FetchNowPlayingMoviesEvent extends HomeEvent {}

///获取最流行
class FetchPopularMoviesEvent extends HomeEvent {}

///获取顶部评分
class FetchTopRatedMoviesEvent extends HomeEvent {}

///获取所有类别
class FetchAllCategorysEvent extends HomeEvent {}
