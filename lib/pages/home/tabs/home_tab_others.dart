import 'dart:ui';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/widgets/custom_slider.dart';
import 'package:movie_app/pages/home/widgets/link_movices.dart';
import 'package:movie_app/pages/home/widgets/slider_card.dart';
import 'package:movie_app/pages/skeletonlib/widgets.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/pages/widgets/skeletonLoading.dart';

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

import 'package:movies_api/src/models/navi/navi_link.dart';

class HomeTabOthers extends StatefulWidget {
  final Categroy_Home categroy;
  const HomeTabOthers({
    Key? key,
    required this.categroy,
  }) : super(key: key);

  @override
  State<HomeTabOthers> createState() => _HomeTabOthersState();
}

class _HomeTabOthersState extends State<HomeTabOthers> {
  MoviesRepository repository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        moviesRepository: repository(context),
      )..add(FetchTabDataByCategoryEvent(categroy: widget.categroy)),
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
        context
            .read<HomeBloc>()
            //.add(FetchUpcomingMoviesEvent());
            .add(FetchTabDataByCategoryEvent(categroy: widget.categroy));
      },
      child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (prev, current) =>
              prev.tabDataByCateState != current.tabDataByCateState,
          builder: (context, homeState) {
            return _buildComponent(
                state: homeState.tabDataByCateState,
                retry: () {
                  context.read<HomeBloc>().add(
                      //FetchUpcomingMoviesEvent());
                      FetchTabDataByCategoryEvent(categroy: widget.categroy));
                });
          }),
    );
  }

  Widget _buildComponent(
      {required AllTabDatabyCategoryState state, required OnRetry retry}) {
    switch (state.status) {
      case Status.success:
        return mainView(state);
      case Status.pending:
        return const ProgressView();
      case Status.error:
        return ErrorView(onRetry: retry);
      case Status.empty:
        return const EmptyView();
      case Status.noConnection:
        return const NoConnectionView();
    }
  }

  Widget mainView(AllTabDatabyCategoryState state) {
    final List<Widget> sliveBoxs = [];
    CustomSlider silder = CustomSlider(
      itemBuilder: (BuildContext context, int itemIndex, int) {
        return Text("");
      },
    );
    if (state.movies.isNotEmpty) {
      //containr_type

      for (var element in state.movies) {
        if (element['container_type'] == "banner") {
          final List<MovieItem> bannerList = [];
          final dataJson = element['data'];
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
          // sliveBoxs.add(SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 175.0,
          //     child: UpcomingMovies(bannerList: bannerList),
          //   ),
          // ));

          silder = CustomSlider(
            itemBuilder: (context, itemIndex, _) {
              return SliderCard(
                media: bannerList[itemIndex],
                itemIndex: itemIndex,
              );
            },
          );

          sliveBoxs.add(SliverToBoxAdapter(
              child: SizedBox(
            height: 170,
            child: silder,
          )));
        } else if (element['container_type'] == "vd-detail") {
        } else if (element['container_type'] == "actor-recommend") {
          //final dataJson = element['data'][0];
          //naviAvtorSummary = NaviAvtor.fromJson(dataJson);
        } else if (element['container_type'] == "vd-summary") {
          //final dataJson = element['data'][0];
          //naviSummary1 = Navi_Summary.fromJson(dataJson);
          List<NaviMutiSummary> navimutisSummarys = [];

          var datas = element['data'];

          for (var element in datas) {
            if (element is Map<String, dynamic>) {
              navimutisSummarys.add(NaviMutiSummary.fromJson(element));
            }
          }

          sliveBoxs.add(
            SliverToBoxAdapter(
              child: SizedBox(
                child: MutiMovies(
                  navimutisSummarys: navimutisSummarys,
                  size: 600.0 * navimutisSummarys.length,
                ), // PopularMovies(size: 366),
              ),
            ),
          );
        } else if (element['container_type'] == "link") {
          final dataJson = element['data'];
          final newlist =
              List<NaviLink>.from(dataJson.map((x) => NaviLink.fromJson(x)));

          sliveBoxs.add(
            SliverToBoxAdapter(
              child: SizedBox(
                child: LinkSummaryMovies(
                    size: 180, index: 3, naviSummary: newlist),
              ),
            ),
          );
        }
      }

      // return SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: sliveBoxs,
      //   ),
      // );

      return CustomScrollView(
        slivers: sliveBoxs,
      );

      // SliverToBoxAdapter(
      //   child: SizedBox(
      //     child: SummaryMovies(
      //       size: 380,
      //       index: 1,
      //       naviSummary: naviSummary1,
      //     ),
      //   ),
      // ),
    } else {
      return const EmptyView();
    }
  }
}
