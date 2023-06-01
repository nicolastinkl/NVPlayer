import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/mylist/bloc/my_list_bloc.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/utils/sliver_grid_delegate.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

class MyListPage extends StatelessWidget {
  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const MyListPage());

  const MyListPage({Key? key}) : super(key: key);

  StorageRepository repository(BuildContext context) {
    return RepositoryProvider.of<StorageRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
        create: (_) => MyListBloc(repository: repository(context)),
        child: const _MyListView(),
      ),
    );
  }
}

class _MyListView extends StatelessWidget {
  const _MyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyListBloc, MyListState>(
      builder: (context, state) {
        return _buildComponents(state);
      },
    );
  }

  Widget _buildComponents(MyListState state) {
    switch (state.status) {
      case Status.success:
        return _ListView(movies: state.movies);
      case Status.pending:
        return const ProgressView();
      case Status.empty:
        return const EmptyView();
      case Status.error:
        return const ErrorView();
      case Status.noConnection:
        return const NoConnectionView();
    }
  }
}

class _ListView extends StatelessWidget {
  const _ListView({Key? key, required this.movies}) : super(key: key);

  final List<MovieItem> movies;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: gridDelegate(context),
            itemCount: movies.length,
            itemBuilder: (context, index) =>
                MovieItemCard(movie: movies[index])),
      ),
    );
  }
}
