import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/common/public.dart';
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
import 'package:movies_api/src/models/navi/navi_mutisummary.dart';

import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/navi/navi_summary.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MutiMovies extends StatefulWidget {
  final double size;
  final List<NaviMutiSummary> navimutisSummarys;

  const MutiMovies(
      {Key? key, required this.size, required this.navimutisSummarys})
      : super(key: key);

  @override
  State<MutiMovies> createState() => _HomeMutiMoviesTabNeweatState();
}

class _HomeMutiMoviesTabNeweatState extends State<MutiMovies> {
  late List<VideoPlayerController> _controllerList = [];
  final GlobalKey _globalKey = GlobalKey();
  late ScrollController _scrollController;
  int _startIndex = 0;
  int _endIndex = 0;

  int _currentIndex = 0; // 当前视图索引

  void navigateToAllMovies(BuildContext context, String categoryId) {
    Navigator.of(context).push(MoviesSeeAllCategory.route(categoryId));
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
    // 启动计时器，停留1-2秒后自动播放视频
  }

  // 视图滚动监听方法，重置计时器和当前视图索引
  void _scrollListener2() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      _currentIndex = 999;
    } else {
      _currentIndex = (_scrollController.offset / 100).floor(); // 根据需要调整宽度
    }
  }

  @override
  void dispose() {
    _controllerList.forEach((element) {
      element.dispose();
    });

    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print("实现您的播放器代码: $_startIndex $_endIndex");
  }

  @override
  Widget build(BuildContext context) {
    /*if (widget.navimutisSummarys.isNotEmpty) {
      for (var elementSum in widget.navimutisSummarys) {
        for (var element in elementSum.resources!) {
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
      }
    }*/

    var listarray = widget.navimutisSummarys
        .map((e) => build6Summayrs(context, e))
        .toList();

    return SizedBox(
        width: double.infinity,
        height: widget.size,
        child: ListView(
          shrinkWrap: false,
          physics: const NeverScrollableScrollPhysics(),
          children: listarray,
        ));
  }

// 判断指定索引是否在屏幕可见范围内
  bool _isIndexVisible(int index) {
    // final RenderBox renderBoxRed =
    //     _globalKey.currentContext!.findRenderObject() as RenderBox;
    // final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    // final sizeRed = renderBoxRed.size;
    // print(positionRed);

    // _controllerList[indexThis].value.isInitialized
    //                       ? Container(
    //                           color: Colors.black,
    //                           width: double.infinity,
    //                           child: AspectRatio(
    //                             aspectRatio: 1.0,
    //                             child: Stack(children: [
    //                               VideoPlayer(_controllerList[indexThis])
    //                             ]),
    //                           ),
    //                         )
    //                       : Container(),
    // final RenderBox renderBoxSubject =
    //     _subjectKey.currentContext.findRenderObject();
    // final positionSubject = renderBoxSubject.localToGlobal(Offset.zero);
    // final sizeSubject = renderBoxSubject.size;

    // final double top = positionRed.dy;
    // final double bottom = positionRed.dy + sizeRed.height;
    // final double subjectTop = positionSubject.dy;
    // final double subjectBottom = positionSubject.dy + sizeSubject.height;
    // final double screenHeight = MediaQuery.of(context).size.height;

    // if ((top > screenHeight && subjectTop > screenHeight) ||
    //     (bottom < 0 && subjectBottom < 0)) {
    //   return false;
    // }

    return true;
  }

  Widget build6Summayrs(BuildContext context, NaviMutiSummary itemSummary) {
    List<Widget> movieitems = [];
    int indexThis = 0;
    Map<String, dynamic> myMap = {"key3": true};

    for (var e in itemSummary.resources!) {
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
                          rate: "",
                          backdropPath: e.videoPreview ?? "",
                          posterPath: e.videoCover ?? "")),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20 + 110.0),
                  child: Text(
                    e.videoTitle ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
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

                //myMap[e.videoPreview ?? ""] ? Container() : Container(),

                // SizedBox(
                //     key: Key('video_$indexThis'),
                //     //key: _key(indexThis), //给每个子widget添加一个动态key
                //     height: 124,
                //     width: double.infinity,
                //     child: Visibility(
                //       visible: _isIndexVisible(indexThis),
                //       child: Container(),
                //     )),
              ],
            ),
          ),
        ),
      );
      indexThis++;
      movieitems.add(item);
    }

    if (movieitems.length < 6) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(itemSummary.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium),
              GestureDetector(
                onTap: () {
                  navigateToAllMovies(context, itemSummary.title ?? "");
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
          height: 600,
          child: ListView(
            shrinkWrap: false,
            controller: _scrollController,
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
                  Row(
                    children: [movieitems[4], movieitems[5]],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
