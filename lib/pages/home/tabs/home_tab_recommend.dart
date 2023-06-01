import 'dart:ui';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/widgets/custom_slider.dart';
import 'package:movie_app/pages/home/widgets/slider_card.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';

import 'package:movie_app/utils/sliver_grid_delegate.dart';
import 'package:movies_data/movies_data.dart';

import 'package:movies_api/src/models/category/category.dart';
import 'package:video_player/video_player.dart';

import 'package:movie_app/pages/home/widgets/avtor_movices.dart';
import 'package:movie_app/pages/home/widgets/muti_movices.dart';
import 'package:movie_app/pages/home/widgets/now_playing_movies.dart';
import 'package:movie_app/pages/home/widgets/popular_movies.dart';
import 'package:movie_app/pages/home/widgets/summary_movices.dart';
import 'package:movie_app/pages/home/widgets/top_rated_movies.dart';
import 'package:movie_app/pages/home/widgets/upcoming_movies.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';

import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/category/category.dart';
import 'package:movie_app/utils/status.dart';

import 'package:movies_api/src/models/navi/navilist.dart';
import 'package:movies_api/src/models/navi/navi_banner.dart';
import 'package:movies_api/src/models/navi/navi_summary.dart';
import 'package:movies_api/src/models/navi/navi_avtor.dart';
import 'package:movies_api/src/models/navi/navi_mutisummary.dart';

class HomeTabRecommend extends StatefulWidget {
  final Categroy_Home categroy_home;
  const HomeTabRecommend({
    Key? key,
    required this.categroy_home,
  }) : super(key: key);

  @override
  State<HomeTabRecommend> createState() => _HomeTabRecommendState();
}

class _HomeTabRecommendState extends State<HomeTabRecommend> {
  MoviesRepository repository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => HomeBloc(
        moviesRepository: repository(context),
      )..add(FetchUpcomingMoviesEvent()),
      // ..add(FetchNowPlayingMoviesEvent())
      // ..add(FetchPopularMoviesEvent())
      // ..add(FetchTopRatedMoviesEvent()),
      // ..add(FetchAllCategorysEvent()),
      child: _HomeView(),
    );
  }

  Widget _HomeView() {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      onRefresh: () async {
        context.read<HomeBloc>().add(FetchUpcomingMoviesEvent());
      },
      child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (prev, current) =>
              prev.upcomingState != current.upcomingState,
          builder: (context, homeState) {
            return _buildComponents(
                state: homeState.upcomingState,
                retry: () {
                  context.read<HomeBloc>().add(FetchUpcomingMoviesEvent());
                });
          }),
    );
  }

  Widget _buildComponents(
      {required UpcomingMoviesState state, required OnRetry retry}) {
    switch (state.status) {
      case Status.success:
        return mainView(state);
      case Status.pending:
        return const ProgressView();
      //
      case Status.error:
        return ErrorView(onRetry: retry);
      case Status.empty:
        return const EmptyView();
      case Status.noConnection:
        return const NoConnectionView();
    }
  }

  Widget mainView(UpcomingMoviesState state) {
    final List<MovieItem> bannerList = [];
    Navi_Summary naviSummary1 = Navi_Summary();
    Navi_Summary naviSummary4 = Navi_Summary();
    NaviAvtor naviAvtorSummary = NaviAvtor();
    List<NaviMutiSummary> navimutisSummarys = [];
    if (state.movies.isNotEmpty) {
      //containr_type
      if (state.movies.first['container_type'] == "banner") {
        final dataJson = state.movies.first['data'];
        final newlist = List<Navi_Banner>.from(
            dataJson.map((x) => Navi_Banner.fromJson(x)));
        for (var element in newlist) {
          bannerList.add(MovieItem(
              id: element.bannerId ?? "",
              title: element.title ?? "",
              rate: "",
              posterPath: element.clickParam?.path ?? "",
              backdropPath: element.coverUri ?? ""));
        }
      }

      int index = 1;
      if (state.movies[index]['container_type'] == "vd-summary") {
        final dataJson = state.movies[index]['data'][0];
        naviSummary1 = Navi_Summary.fromJson(dataJson);
      }

      int index4 = 4;
      if (state.movies[index4]['container_type'] == "vd-summary") {
        final dataJson = state.movies[index4]['data'][0];
        naviSummary4 = Navi_Summary.fromJson(dataJson);
      }
      int indexator = 3;
      if (state.movies[indexator]['container_type'] == "actor-recommend") {
        final dataJson = state.movies[indexator]['data'][0];
        naviAvtorSummary = NaviAvtor.fromJson(dataJson);
      }

      if (state.movies[7]['container_type'] == "vd-summary") {
        var datas = state.movies[7]['data'];

        for (var element in datas) {
          if (element is Map<String, dynamic>) {
            navimutisSummarys.add(NaviMutiSummary.fromJson(element));
          }
        }
        // final dataJson = state.movies.last['data'][0];
        // naviSummary = Navi_Summary.fromJson(dataJson);
      }
    }

    CustomSlider silder = CustomSlider(
      itemBuilder: (context, itemIndex, _) {
        return SliderCard(
          media: bannerList[itemIndex],
          itemIndex: itemIndex,
        );
      },
    );

    return CustomScrollView(
      slivers: [
        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 175.0,
        //     child: UpcomingMovies(bannerList: bannerList),
        //   ),
        // ),
        SliverToBoxAdapter(
            child: SizedBox(
          height: 170,
          child: silder,
        )),
        SliverToBoxAdapter(
          child: SizedBox(
            child: SummaryMovies(
              size: 380,
              index: 1,
              naviSummary: naviSummary1,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            child: SummaryMovies(
              size: 380,
              index: 4,
              naviSummary: naviSummary4,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            child: ActorSummaryMovies(
                size: 180, index: 3, naviSummary: naviAvtorSummary),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            child: MutiMovies(
              navimutisSummarys: navimutisSummarys,
              size: 600.0 * navimutisSummarys.length,
            ), // PopularMovies(size: 366),
          ),
        ),
      ],
    );
  }
}
