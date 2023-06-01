import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/movies_see_all.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

class LatestMovies extends StatelessWidget {
  final double size;

  const LatestMovies({Key? key, required this.size}) : super(key: key);

  void navigateToAllMovies(BuildContext context) {
    Navigator.of(context).push(MoviesSeeAll.route(MovieType.NOW_PLAYING));
  }

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
              Text(context.l10n.nowPlaying,
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
                prev.nowPlayingState != current.nowPlayingState,
            builder: (context, homeState) {
              return _buildComponents(
                state: homeState.nowPlayingState,
                retry: () {
                  context.read<HomeBloc>().add(FetchNowPlayingMoviesEvent());
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildComponents({
    required NowPlayingMoviesState state,
    required OnRetry retry,
  }) {
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
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
    );
  }
}
