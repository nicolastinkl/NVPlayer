import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/utils/typedef/functions.dart';
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
import 'package:movies_api/src/models/navi/navi_summary.dart';
import 'package:video_player/video_player.dart';

class SummaryMovies extends StatefulWidget {
  final double size;
  final int index;
  final Navi_Summary naviSummary;

  const SummaryMovies(
      {Key? key,
      required this.size,
      required this.index,
      required this.naviSummary})
      : super(key: key);

  @override
  State<SummaryMovies> createState() => _HomeSummaryMoviesTabNeweatState();
}

class _HomeSummaryMoviesTabNeweatState extends State<SummaryMovies> {
  late List<VideoPlayerController> _controllerList = [];

  void navigateToAllMovies(BuildContext context, String categoryId) {
    Navigator.of(context).push(MoviesSeeAllCategory.route(categoryId));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerList.forEach((element) {
      element.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* if (widget.naviSummary.resources != null) {
      for (var element in widget.naviSummary.resources!) {
        VideoPlayerController controller = VideoPlayerController.network(
          element.videoPreview!
              .replaceAll("https://w1.zikl.xyz", "http://45.125.51.92"),
        )..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
        _controllerList.add(controller);
        controller.setLooping(true);
      }
    }*/

    return _MoviesView();
  }

  Widget _MoviesView() {
    int indexThis = 0;

    List<Widget> movieitems = [];

    for (var e in widget.naviSummary.resources!) {
      var item = Expanded(
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
                  child: MovieItemCard(
                      movie: MovieItem(
                          id: e.resKey ?? "",
                          title: e.videoTitle ?? "",
                          rate: getDateFromTimeSpan(e.createdTick ?? 0),
                          backdropPath: e.videoPreview ?? "",
                          posterPath: e.videoCover ?? "")),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20 + 110.0),
                  child: Text(
                    e.videoTitle ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                // const Icon(IconlyBold.discovery),
                Container(
                  margin: const EdgeInsets.only(top: 20 + 90.0, left: 4.0),
                  child: Text(
                    e.durationStr ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                /*SizedBox(
                  key: Key('video_$indexThis'),
                  // key: ValueKey(index), //给每个子widget添加一个动态key
                  height: 124,
                  width: double.infinity,
                  child: _controllerList[indexThis].value.isInitialized
                      ? Container(
                          color: Colors.black,
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(children: [
                              VideoPlayer(_controllerList[indexThis])
                            ]),
                          ),
                        )
                      : Container(),
                ),*/
              ],
            ),
          ),
        ),
      );

      movieitems.add(item);

      indexThis++;
    }
    if (movieitems.length >= 4) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.naviSummary.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium),
                GestureDetector(
                  onTap: () {
                    navigateToAllMovies(
                        context, widget.naviSummary.title ?? "");
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
            height: widget.size,
            child: ListView(
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
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
