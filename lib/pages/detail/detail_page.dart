import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/detail/components/details_card.dart';
import 'package:movie_app/pages/detail/components/movie_card_details.dart';
import 'package:movie_app/pages/detail/widgets/similar_movies_list.dart';
import 'package:movie_app/pages/detail/widgets/videos_list.dart';
import 'package:movie_app/pages/skeletonlib/stylings.dart';
import 'package:movie_app/pages/skeletonlib/widgets.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/pages/widgets/skeletonLoading.dart';
import 'package:movie_app/resources/app_colors.dart';
import 'package:movie_app/resources/app_values.dart';

import 'package:movie_app/resources/app_shape.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatelessWidget {
  final String movieId;

  static Route<void> route(String movieId) =>
      MaterialPageRoute(builder: (_) => DetailPage(movieId: movieId));

  const DetailPage({Key? key, required this.movieId}) : super(key: key);

  MoviesRepository movieRepository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  StorageRepository storageRepository(BuildContext context) =>
      RepositoryProvider.of<StorageRepository>(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailMovieBloc(
        moviesRepository: movieRepository(context),
        storageRepository: storageRepository(context),
      )..add(FetchedMovieEvent(movieId: movieId)),
      child: Scaffold(
        body: MovieDetailView(movieId),
      ),
    );
  }
}

class MovieDetailView extends StatelessWidget {
  const MovieDetailView(this.movieId, {Key? key}) : super(key: key);
  final String movieId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        return _buildComponents(context, state);
      },
    );
  }

  Widget _buildComponents(BuildContext context, DetailMovieState state) {
    switch (state.status) {
      case Status.success:
        return _DetailView(state);
      case Status.pending:
        // return const _skeletonView();
        // return const SkeletonLoading();
        return const ProgressView();
      case Status.empty:
        return const EmptyView();
      case Status.error:
        return ErrorView(onRetry: () {
          context
              .read<DetailMovieBloc>()
              .add(FetchedMovieEvent(movieId: movieId));
        });
      case Status.noConnection:
        return NoConnectionView(callback: () {
          context
              .read<DetailMovieBloc>()
              .add(FetchedMovieEvent(movieId: movieId));
        });
    }
  }
}

class _DetailView extends StatefulWidget {
  const _DetailView(this.state, {Key? key}) : super(key: key);

  final DetailMovieState state;

  @override
  State<_DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<_DetailView>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 2, vsync: this);
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  ///
  /// [@var		mixed	context]
  ///
  void addToFavorite(BuildContext context, MovieDetail movie) {
    context.read<DetailMovieBloc>().add(BookmarkEvent(
        item: MovieItem(
            id: movie.id,
            title: movie.title,
            rate: movie.rating,
            posterPath: movie.poserPath,
            backdropPath: movie.backdropPath)));
  }

  ///
  /// [@var		object	async]
  ///
  Future<void> share() async {
    await Share.share(widget.state.movie!.title);
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.state.movie!;
    final casts = widget.state.casts;
    final isMarked = widget.state.isMarked;
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      onRefresh: () async {
        context
            .read<DetailMovieBloc>()
            .add(FetchedMovieEvent(movieId: movie.id));
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            title: Text(
              movie.title,
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                onPressed: share,
                icon: Icon(
                  IconlyLight.send,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              IconButton(
                onPressed: () {
                  addToFavorite(context, movie);
                },
                icon: isMarked
                    ? Icon(
                        IconlyBold.bookmark,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : Icon(
                        IconlyLight.bookmark,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
              ),
            ],
          ),
          SliverPaddingContainer(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: DetailsCard(
                  mediaDetails: movie,
                  detailsWidget: MovieCardDetails(movieDetails: movie),
                ),
              ),
            ),
          ),
          /* SliverPaddingContainer(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: CachedNetworkImage(
                  imageUrl: movie.backdropPath,
                  placeholder: (context, url) => const ProgressView(),
                  errorWidget: (context, url, error) => Icon(
                    IconlyBold.image,
                    size: 100,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverPaddingContainer(
            top: 25,
            left: 20,
            right: 20,
            child: _timeAndRating(
              time: movie.duration,
              rating: movie.rating,
            ),
          ),
          SliverPaddingContainer(
            top: 16,
            left: 20,
            right: 20,
            child: _releaseDateAndGenre(
              date: movie.releaseData,
              genres: movie.genres,
            ),
          ),*/
          SliverPaddingContainer(
            top: 16,
            left: 20,
            right: 20,
            child: Text(
              movie.overview,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SliverPaddingContainer(top: 16, bottom: 16, child: _CastsView(casts)),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
                labelColor: Theme.of(context).colorScheme.secondary,
                indicatorColor: Theme.of(context).colorScheme.secondary,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                controller: _tabController,
                tabs: [
                  // Tab(text: context.l10n.videos),
                  Tab(text: context.l10n.similarMovies),
                ],
              ),
            ),
          ),
          if (_currentIndex == 1)
            const SliverPadding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              sliver: VideosList(),
            ),
          if (_currentIndex == 0)
            const SliverPadding(
              padding: EdgeInsets.only(
                top: 20,
                left: 8,
                right: 8,
                bottom: 20,
              ),
              sliver: SimilarMoviesList(),
            ),
        ],
      ),
    );
  }

  Widget _timeAndRating({
    required String time,
    required String rating,
  }) {
    return Row(
      children: [
        const Icon(IconlyBold.time_circle, color: Colors.blue, size: 18),
        const SizedBox(width: 10),
        Text(
          context.l10n.minutes(time),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 10),
        const Icon(IconlyBold.star, color: Colors.amber, size: 18),
        const SizedBox(width: 10),
        Text(
          context.l10n.imdb(rating),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _releaseDateAndGenre({
    required List<String> genres,
    required String date,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Release Date section
          Text(
            context.l10n.releaseDate(date),
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 5),

          // Genre section
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.genre,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                runAlignment: WrapAlignment.end,
                children: genres
                    .map(
                      (text) => Container(
                        // margin: const EdgeInsets.only(top: 4, right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withAlpha(20),
                          ),
                          borderRadius:
                              BorderRadius.circular(AppShape.normalShaper),
                          gradient: AppColors.gradient,
                        ),
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CastsView extends StatelessWidget {
  const _CastsView(this.casts, {Key? key}) : super(key: key);

  final List<CastItem> casts;

  @override
  Widget build(BuildContext context) {
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
              child: CircleAvatar(
                backgroundImage: NetworkImage(casts[index].profilePath!),
              ),
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

class SliverPaddingContainer extends StatelessWidget {
  const SliverPaddingContainer(
      {Key? key,
      this.top = 0.0,
      this.bottom = 0.0,
      this.right = 0.0,
      this.left = 0.0,
      required this.child})
      : super(key: key);

  final double top;
  final double right;
  final double left;
  final double bottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Theme.of(context).colorScheme.background, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
