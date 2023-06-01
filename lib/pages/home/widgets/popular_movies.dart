import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/movies_see_all.dart';
import 'package:movie_app/pages/home/movies_see_category.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/resources/app_values.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

class PopularMovies extends StatelessWidget {
  final double size;

  const PopularMovies({Key? key, required this.size}) : super(key: key);

  void navigateToAllMovies(BuildContext context) {
    Navigator.of(context).push(MoviesSeeAll.route(MovieType.POPULAR));
  }

  // void navigateToAllMovies(BuildContext context, String categoryId) {
  //   Navigator.of(context).push(MoviesSeeAllCategory.route(categoryId));
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.popular,
                  style: Theme.of(context).textTheme.titleMedium),
              GestureDetector(
                onTap: () {
                  navigateToAllMovies(context);
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
          height: size,
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (prev, current) =>
                prev.popularState != current.popularState,
            builder: (context, homeState) {
              return _buildComponents(
                state: homeState.popularState,
                retry: () {
                  context.read<HomeBloc>().add(FetchPopularMoviesEvent());
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildComponents(
      {required PopularMoviesState state, required OnRetry retry}) {
    switch (state.status) {
      case Status.success:
        return _MoviesView(movies: state.movies, itemSize: size);
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
}

class _MoviesView extends StatelessWidget {
  const _MoviesView({Key? key, required this.movies, required this.itemSize})
      : super(key: key);

  /// Single Item size
  final double itemSize;

  /// Movies coming remote or local storage
  final List<MovieItem> movies;

  @override
  Widget build(BuildContext context) {
    List<Widget> movieitems = movies
        .map((e) => Expanded(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 4,
                    right: 4,
                  ),
                  height: 124,
                  width: MediaQuery.of(context).size.width / 2 * 0.8,
                  child: // MovieItemCard(movie: e),
                      Stack(
                    children: [
                      SizedBox(
                        height: 124,
                        width: double.infinity,
                        child: MovieItemCard(movie: e),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20 + 110.0),
                        child: Text(
                          e.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      // const Icon(IconlyBold.discovery),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20 + 90.0, left: 4.0),
                        child: Text(
                          e.rate,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();

    return ListView(
      shrinkWrap: false,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: [
            Row(
              children: [movieitems[0], movieitems[1]],
            ),
            Row(
              children: [movieitems[2], movieitems[3]],
            ),
          ],
        ),
      ],
    );

    // return ListView.builder(
    //   // scrollDirection: Axis.horizontal,
    //   shrinkWrap: false,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: 6,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       margin: EdgeInsets.only(
    //         left: 8,
    //         right: index == movies.length - 1 ? 8 : 0,
    //       ),
    //       height: 174,
    //       width: MediaQuery.of(context).size.width / 2 * 0.8,
    //       child: MovieItemCard(movie: movies[index]),
    //     );
    //   },
    // );

    /* return ListView.builder(
      // scrollDirection: Axis.horizontal,
      shrinkWrap: false,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            left: 8,
            right: index == movies.length - 1 ? 8 : 0,
          ),
          height: itemSize,
          width: itemSize * 0.8,
          child: MovieItemCard(movie: movies[index]),
        );
      },
    );*/
  }
}
