import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/pages/components/avatar.dart';

import 'package:movie_app/pages/components/cast_card.dart';
import 'package:movie_app/pages/components/section_listview.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/detail/components/slider_card_image.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/movies_see_all.dart';
import 'package:movie_app/pages/home/movies_see_category.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/resources/app_strings.dart';
import 'package:movie_app/resources/app_values.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/navi/navi_avtor.dart';

class ActorSummaryMovies extends StatelessWidget {
  final double size;
  final int index;
  final NaviAvtor naviSummary;

  const ActorSummaryMovies(
      {Key? key,
      required this.size,
      required this.index,
      required this.naviSummary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MoviesView(navi_summary: naviSummary, itemSize: size);

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, current) => prev.upcomingState != current.upcomingState,
      builder: (context, homeState) {
        return _buildComponents(
            state: homeState.upcomingState,
            retry: () {
              context.read<HomeBloc>().add(FetchUpcomingMoviesEvent());
            });
      },
    );
  }

  Widget _buildComponents(
      {required UpcomingMoviesState state, required OnRetry retry}) {
    NaviAvtor naviSummary = NaviAvtor();

    if (state.movies.isNotEmpty) {
      //containr_type

      if (state.movies[index]['container_type'] == "actor-recommend") {
        final dataJson = state.movies[index]['data'][0];
        naviSummary = NaviAvtor.fromJson(dataJson);
      }
      switch (state.status) {
        case Status.success:
          return _MoviesView(navi_summary: naviSummary, itemSize: size);
        case Status.pending:
          return const ProgressView();
        case Status.error:
          return ErrorView(onRetry: retry);
        case Status.empty:
          return const EmptyView();
        case Status.noConnection:
          return const NoConnectionView();
      }
    } else {
      return const SizedBox(
        height: 0,
      );
    }
  }
}

class _MoviesView extends StatelessWidget {
  const _MoviesView(
      {Key? key, required this.navi_summary, required this.itemSize})
      : super(key: key);
  void navigateToAllMovies(BuildContext context, String categoryId) {
    Navigator.of(context).push(MoviesSeeAllCategory.route(categoryId));
  }

  /// Single Item size
  final double itemSize;

  /// Movies coming remote or local storage
  // final List<MovieItem> movies;
  final NaviAvtor navi_summary;

  @override
  Widget build(BuildContext context) {
    List<CastItem> casts = [];
    for (var element in navi_summary.resources!) {
      casts.add(CastItem(
          creditId: element.resKey ?? "",
          originalName: element.actorName,
          profilePath: element.actorAvatarUri ?? "",
          id: 0,
          gender: 0,
          age: element.age ?? "",
          bwh: element.bwh ?? "",
          body: element.body ?? "",
          res_tid_name: element.resTidName ?? "",
          character: element.body ?? ""));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(navi_summary.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium),
              GestureDetector(
                onTap: () {
                  navigateToAllMovies(context, navi_summary.title ?? "");
                },
                child: Text(
                  context.l10n.seeAll,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: itemSize,
          child: buildAvtor(context, casts),
        ),
      ],
    );
  }

  Widget buildAvtor(BuildContext context, List<CastItem> casts) {
    if (casts != null && casts.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionListView(
            height: AppSize.s175,
            itemCount: casts.length,
            itemBuilder: (context, index) => CastCard(
              cast: casts[index],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 65,
              width: 65,
              child: Avatar(avatarUrl: ""),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(casts[index].profilePath!),
              // ),
            ),
            SizedBox(
              width: 100,
              height: 20,
              child: Text(
                casts[index].originalName ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
