import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/movies/widgets/movies_grid_list.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/utils/strings.dart';
import 'package:movies_data/movies_data.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  Stream<List<GenreItem>> getActiveGenresStream(BuildContext context) {
    return RepositoryProvider.of<StorageRepository>(context).getActiveGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getActiveGenresStream(context),
      builder: (context, snapshot) {
        return _buildComponent(snapshot);
      },
    );
  }

  Widget _buildComponent(AsyncSnapshot<List<GenreItem>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const ProgressView();
    } else if (snapshot.hasData) {
      return _MainPage(genres: snapshot.data ?? []);
    } else {
      return const EmptyView();
    }
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage({Key? key, required this.genres}) : super(key: key);
  final List<GenreItem> genres;

  @override
  Widget build(BuildContext context) => genres.isEmpty
      ? const EmptyView()
      : DefaultTabController(
          length: genres.length,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: true,
                  elevation: 0.0,
                  title: const Text(movies),
                  bottom: TabBar(
                    isScrollable: true,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onPrimary,
                    labelColor: Theme.of(context).colorScheme.onPrimary,
                    indicatorColor: Theme.of(context).colorScheme.secondary,
                    tabs: genres.map((genre) => Tab(text: genre.name)).toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: genres
                  .map((genre) => MoviesGridView(genreId: genre.id))
                  .toList(),
            ),
          ),
        );
}

class TabIndicator extends Decoration {
  const TabIndicator({required this.color});

  final Color color;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return TabPainter(color: color);
  }
}

class TabPainter extends BoxPainter {
  const TabPainter({required this.color});

  final Color color;

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    Paint paint = Paint();
    paint.color = color;
    paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 2.0);
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;

    /*
      print('Height: ${configuration.size!.height}');
      print('Width: ${configuration.size!.width}');
      print('Offset X: ${offset.dx}');
      print('Offset Y: ${offset.dy}');

      flutter : Config Height: 48.0
      flutter : Config Width: 88.0
      flutter : Offset X: 613.0
      flutter : Offset Y: 0.0

      final A = Offset(dx, dy);
      final B = Offset(dx, dy);
                                final rect = Rect.fromPoints(A, B);
                                                                        x = 88
                                                          --------------------------------------
                                                          |                                    |
                                                          |                                    |
                                                          |                                    |
      A                                                 A *----------------------              | y = 48
    y = config.size.height - (config.size.height * 0.1)   |                     |              |
    x = offsetX                                           |          *          |              |
                                                          |        center       |              |
                                                          ----------------------*---------------
                                                                                B
                                                                   B => | y = config.size.height
                                                                        | x = offsetX + (config.size.width / 2)
    */
    final configWidth = configuration.size?.width ?? 1.0;
    final configHeight = configuration.size?.height ?? 1.0;
    final center = Offset(
      (offset.dx + (configWidth / 4)),
      (configHeight - (configHeight * 0.1)),
    );
    var roundedRectangle = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: (configWidth / 2) - 20,
        height: (configHeight * 0.05),
      ),
      const Radius.circular(5.0),
    );
    // final a = Offset(offset.dx + 12, (configHeight - (configHeight * 0.1)));
    // final b = Offset(((configWidth / 2) + offset.dx), configHeight);
    // final rect = Rect.fromPoints(a, b);
    canvas.drawRRect(roundedRectangle, paint);
  }
}
