import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/utils/sliver_grid_delegate.dart';
import 'package:movies_data/movies_data.dart';

class MoviesGridView extends StatefulWidget {
  final String genreId;

  const MoviesGridView({Key? key, required this.genreId}) : super(key: key);

  @override
  State<MoviesGridView> createState() => _MoviesGridViewState();
}

class _MoviesGridViewState extends State<MoviesGridView> {
  static const _pageSize = 20;
  late PagingController<int, MovieItem> _pagingController;

  var _connectionChecker = false;

  @override
  void initState() {
    InternetConnectionChecker().connectionStatus.then((value) {
      setState(() {
        _connectionChecker = value == InternetConnectionStatus.disconnected;
      });
    });

    _pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    final repository = RepositoryProvider.of<MoviesRepository>(context);

    final responseState = await repository.discoverMovies(
      page: pageKey,
      genreId: widget.genreId,
    );
    if (responseState is Success) {
      final data = responseState.successValue;

      final movies = data.movies ?? [];
      final isLastPage = movies.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(movies);
      } else {
        final nextPageKey = (data.page ?? pageKey) + 1;
        _pagingController.appendPage(movies, nextPageKey);
      }
    } else if (responseState is NoConnection) {
      _pagingController.error = responseState.errorValue;
    } else if (responseState is Fail) {
      _pagingController.error = responseState.errorValue;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void navigate(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: _connectionChecker
            ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const NoConnectionView();
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PagedGridView<int, MovieItem>(
                  showNewPageProgressIndicatorAsGridChild: false,
                  showNewPageErrorIndicatorAsGridChild: false,
                  showNoMoreItemsIndicatorAsGridChild: false,
                  gridDelegate: gridDelegate(context),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<MovieItem>(
                    itemBuilder: (context, movie, index) =>
                        MovieItemCard(movie: movie),
                    firstPageErrorIndicatorBuilder: (_) => ErrorView(
                      message: _pagingController.error,
                      onRetry: () => _pagingController.refresh(),
                    ),
                    newPageErrorIndicatorBuilder: (_) => ErrorView(
                      message: _pagingController.error,
                      onRetry: () => _pagingController.refresh(),
                    ),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const ProgressView(),
                    newPageProgressIndicatorBuilder: (_) =>
                        const ProgressView(),
                    // noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(),
                    // noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(),
                  ),
                ),
              ),
      );
}
