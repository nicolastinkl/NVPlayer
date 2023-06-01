import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/detail/components/slider_card_image.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/videoplayer/player_page.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/resources/app_colors.dart';

import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/navi/navilist.dart';
import 'package:movies_api/src/models/navi/navi_banner.dart';

class UpcomingMovies extends StatefulWidget {
  const UpcomingMovies({super.key, required this.bannerList});
  final List<MovieItem> bannerList;

  @override
  State<UpcomingMovies> createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MoviesView(
      movies: widget.bannerList,
      pageController: _pageController,
    );

    // return BlocBuilder<HomeBloc, HomeState>(
    //     buildWhen: (prev, current) =>
    //         prev.upcomingState != current.upcomingState,
    //     builder: (context, homeState) {
    //       return _buildComponents(
    //           state: homeState.upcomingState,
    //           retry: () {
    //             context.read<HomeBloc>().add(FetchUpcomingMoviesEvent());
    //           });
    //     });
  }

  Widget _buildComponents(
      {required UpcomingMoviesState state, required OnRetry retry}) {
    List<MovieItem> bannerList = [];
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

      switch (state.status) {
        case Status.success:
          return _MoviesView(
            movies: bannerList,
            pageController: _pageController,
          );
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

    // state.movies.forEach((element) {

    // if (json['containerType'] == "banner") {
    //   print(json);
    // }
    // if (element.containerType == "banner") {
    //   element.data?.forEach((element) {
    // bannerList.add(MovieItem(
    //     id: element.bannerId ?? "",
    //     title: element.title ?? "",
    //     rate: "",
    //     posterPath: element.coverUri ?? "",
    //     backdropPath: element.clickParam?.path ?? ""));
    // });
    // }
    // });
  }
}

class _MoviesView extends StatelessWidget {
  const _MoviesView(
      {Key? key, required this.movies, required this.pageController})
      : super(key: key);

  /// Movies coming remote or local storage
  final List<MovieItem> movies;

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _MovieItemPage(
          movie: movie,
        );
      },
    );
  }
}

class _MovieItemPage extends StatelessWidget {
  const _MovieItemPage({Key? key, required this.movie}) : super(key: key);
  final MovieItem movie;

  void navigateToPlayer(BuildContext context, String movieId) {
    Navigator.of(context).push(PlayerPage.route(movieId: movieId));
  }

  void navigateToDetail(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToDetail(context, movie.id);
      },
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SliderCardImage(imageUrl: movie.backdropPath),
            /*CachedNetworkImage(
              imageUrl: movie.backdropPath,
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              )),
              errorWidget: (context, url, error) => Icon(
                IconlyBold.image,
                size: 100,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              fit: BoxFit.cover,
            ),*/
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [Colors.transparent, AppColors.darkPrimaryColor],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                /*
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        navigateToPlayer(context, movie.id);
                      },
                      icon: const Icon(Icons.play_circle, color: Colors.white),
                      label: Text(
                        context.l10n.play,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: Text(
                        context.l10n.myList,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                    )
                  ],
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
