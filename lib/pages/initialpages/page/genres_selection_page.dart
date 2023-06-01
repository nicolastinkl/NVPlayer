import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/initialpages/bloc/register_bloc.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/genre_item_widget.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movie_app/utils/strings.dart';
import 'package:movies_data/movies_data.dart';

///
/// [GenresSelectionPage.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, March 28th, 2023]
/// [@see		StatelessWidget]
/// [@global]
///
class GenresSelectionPage extends StatelessWidget {
  const GenresSelectionPage({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const GenresSelectionPage());

  AuthRepository authRepository(BuildContext context) =>
      RepositoryProvider.of<AuthRepository>(context);

  StorageRepository storageRepository(BuildContext context) =>
      RepositoryProvider.of<StorageRepository>(context);

  MoviesRepository moviesRepository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Chose Your Interests'),
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (_) => RegisterBloc(
          authRepository: authRepository(context),
          moviesRepository: moviesRepository(context),
          storageRepository: storageRepository(context),
        )..add(const FetchGenresEvent()),
        child: const _MainView(),
      ),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return _buildComponents(
          state: state,
          retry: () {
            context.read<RegisterBloc>().add(const FetchGenresEvent());
          },
        );
      },
    );
  }

  Widget _buildComponents({required RegisterState state, OnRetry? retry}) {
    switch (state.status) {
      case Status.success:
        return _SelectionView(genres: state.genres);
      case Status.pending:
        return const ProgressView();
      case Status.empty:
        return const EmptyView();
      case Status.error:
        return ErrorView(onRetry: retry);
      case Status.noConnection:
        return const NoConnectionView();
    }
  }
}

class _SelectionView extends StatelessWidget {
  const _SelectionView({Key? key, required this.genres}) : super(key: key);

  final List<GenreItem> genres;

  void genreSelection(BuildContext context, GenreItem genre) {
    context.read<RegisterBloc>().add(ChangeFlagEvent(genre));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(12.0),
          child: Text(
              style: Theme.of(context).textTheme.bodyMedium,
              choseFavoriteGenre),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Wrap(
              children: genres
                  .map((item) => GenreItemWidget(
                      selected: item.isActive,
                      genre: item.name,
                      onSelected: () {
                        genreSelection(context, item);
                      }))
                  .toList(),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: null,
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    child: const Text(skip),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RegisterBloc>().add(FinishRegisterEvent());
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    child: const Text(continui),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
