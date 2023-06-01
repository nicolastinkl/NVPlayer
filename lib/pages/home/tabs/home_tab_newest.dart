import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';

import 'package:movie_app/utils/sliver_grid_delegate.dart';
import 'package:movies_data/movies_data.dart';

import 'package:movies_api/src/models/category/category.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeTabNeweat extends StatefulWidget {
  final Categroy_Home categroy_home;
  const HomeTabNeweat({Key? key, required this.categroy_home})
      : super(key: key);

  @override
  State<HomeTabNeweat> createState() => _HomeTabNeweatState();
}

class _HomeTabNeweatState extends State<HomeTabNeweat> {
  static const _pageSize = 20;
  late PagingController<int, MovieItem> _pagingController;
  late List<VideoPlayerController> _controllerList = [];
  // final _scrollController = ScrollController();
  final GlobalKey globalKey = GlobalKey();
  final GlobalKey keyContainer = GlobalKey();

  // bool _isPlaying = false;
  // bool _isVisible = false; // 记录Widget是否可见

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener(_fetchPage);
    super.initState();
    // _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_scrollListener);
    _pagingController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // 计算视频在屏幕中心时的位置
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double videoHeight = 150; // 获取视频高度
    // final double videoPosition =
    //     _scrollController.offset + videoHeight / 2 - screenHeight / 2;

    // // 检查视频是否处于屏幕中心，并自动播放
    // if (videoPosition >= 0 && videoPosition <= videoHeight && !_isPlaying) {
    //   setState(() {
    //     _isPlaying = true;
    //   });
    //   // 执行自动播放的逻辑
    // }

    // 这里就可以获取到当前展示的第一项的索引

    //判断每个子widget是否滚动到了屏幕中间位置
    //   for (int i = 0; i < children.length; i++) {
    //     final RenderBox childRenderBox =
    //         globalKey.currentContext.findRenderObject();
    //     final childOffset = childRenderBox.localToGlobal(Offset.zero);
    //     final childCenter = Offset(
    //       childOffset.dx + childRenderBox.size.width / 2,
    //       childOffset.dy + childRenderBox.size.height / 2,
    //     );
    //     if (center.distanceTo(childCenter) < center.dx ||
    //         center.distanceTo(childCenter) < center.dy) {
    //       print('子widget${i + 1}已经滚动到了屏幕中间');
    //     }
    //   }
    // });

    // if (_scrollController.position.maxScrollExtent ==
    //     _scrollController.offset) {
    //   // 到达了列表的底部
    // } else if (_scrollController.offset ==
    //     _scrollController.position.minScrollExtent) {
    //   // 到达了列表的顶部
    // } else {
    //   // 其他情况
    // }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final repository = RepositoryProvider.of<MoviesRepository>(context);

      // final data = await repository.getMoviesByType(
      //     page: pageKey,
      //     type: MovieType.TOP_RATED //widget.categroy_home.navbarId ?? "",
      //     );
      //32zwcrdac1h hotview 最新
      final data = await repository.getMoviesByNewest(
          page: pageKey, navireskey: "32zwcrdac1h");
      final result = data.getValueOrNull();

      final movies = result?.movies ?? [];
      final isLastPage = movies.length < _pageSize;

      for (var element in movies) {
        VideoPlayerController controller = VideoPlayerController.network(
          element.backdropPath
              .replaceAll("https://w1.zikl.xyz", "http://45.125.51.92"),
        )..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
        controller.setLooping(true);
        controller.play();
        _controllerList.add(controller);
      }

      if (isLastPage) {
        _pagingController.appendLastPage(movies);
      } else {
        final nextPageKey = (result?.page ?? pageKey) + 1;
        _pagingController.appendPage(movies, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Widget isPlaying() {
    return Icon(
      Icons.play_arrow,
      size: 40,
      color: Colors.white.withOpacity(0.5),
    );
  }

  Widget newestVideoItem(BuildContext context, MovieItem movie, int index) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
            margin: const EdgeInsets.only(
              left: 0,
              right: 0,
            ),
            // width: MediaQuery.of(context).size.width ,
            child: Stack(
              children: [
                SizedBox(
                  height: 212,
                  width: double.infinity,
                  child: MovieItemCard(movie: movie),
                ),
                SizedBox(
                  key: Key('video_$index'),
                  // key: ValueKey(index), //给每个子widget添加一个动态key
                  height: 212,
                  width: double.infinity,
                  child: _controllerList[index].value.isInitialized
                      ? Container(
                          color: Colors.black,
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(children: [
                              VideoPlayer(_controllerList[index]),
                              Container(
                                child: const Center(
                                  child: Text("视频预览中..."),
                                ),
                                margin: EdgeInsets.only(bottom: 15),
                              )
                            ]),
                          ),
                        )
                      : Container(),
                ),
                // 在需要检测可见性的Widget上使用VisibilityDetector组件
                // VisibilityDetector(
                //   key: Key('video_$index'),
                //   onVisibilityChanged: (visibilityInfo) {
                //     print(visibilityInfo.visibleFraction);
                //     setState(() {
                //       _isVisible = visibilityInfo.visibleFraction >=
                //           1; // 当可见性超过80%时，认为该Widget已经完全可见
                //     });
                //   },
                //   child: _isVisible
                //       ?

                //       : Container(),
                // ),

                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    movie.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                  ),
                ),
                // const Icon(IconlyBold.discovery),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 200, right: 8.0),
                  child: Text(
                    movie.rate,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.8))),
                    child: isPlaying(),
                  ),
                ),
                //添加用户头像显示
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 215, left: 4.0),
                  child: buildAvtor(context, movie),
                ),
              ],
            )),
      ),
    );

    //return MovieItemCard(movie: movie);
  }

  Widget buildAvtor(BuildContext context, MovieItem movie) {
    return SizedBox(
        height: 40,
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage((movie.uploadUserUri ?? "")
                    .replaceAll("https://w1.zikl.xyz", "http://45.125.51.92")),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, top: 5),
              child: SizedBox(
                width: double.infinity / 2,
                height: 40,
                child: Text(
                  movie.uploadUserNickname ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     icon: const Icon(Icons.arrow_back_sharp),
      //   ),
      //   title: Text(widget.categroy_home.navbarName ?? ""),
      //   elevation: 0.0,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: RefreshIndicator(
          color: Theme.of(context).colorScheme.onPrimary,
          onRefresh: () async {
            _pagingController.refresh();
          },
          child: PagedGridView<int, MovieItem>(
            key: keyContainer,
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            gridDelegate: gridDelegateNewest(context),
            // scrollController: _scrollController,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<MovieItem>(
              itemBuilder: (context, movie, index) =>
                  newestVideoItem(context, movie, index),
              firstPageErrorIndicatorBuilder: (_) => _FirstPageErrorIndicator(
                error: _pagingController.error,
                onTryAgain: () => _pagingController.refresh(),
              ),
              newPageErrorIndicatorBuilder: (_) => _FirstPageErrorIndicator(
                error: _pagingController.error,
                onTryAgain: () => _pagingController.retryLastFailedRequest(),
              ),
              firstPageProgressIndicatorBuilder: (_) => Container(
                margin: const EdgeInsets.all(16.0),
                child: const ProgressView(),
              ),
              newPageProgressIndicatorBuilder: (_) => Container(
                margin: const EdgeInsets.all(16.0),
                child: const ProgressView(),
              ),
              // noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(),
              // noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class _FirstPageErrorIndicator extends StatelessWidget {
  final Object error;
  final void Function() onTryAgain;

  const _FirstPageErrorIndicator({
    required this.error,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: Text(
              '$error',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
              onPressed: onTryAgain, child: Text(context.l10n.tryAgain)),
        ],
      ),
    );
  }
}

SliverGridDelegate gridDelegateNewest(BuildContext context) {
  return const SliverGridDelegateWithFixedCrossAxisCount(
    // crossAxisCount: MediaQuery.of(context).size.width > 500.0 ? 4 : 2,
    // mainAxisSpacing: 10,
    // crossAxisSpacing: 10,
    childAspectRatio: 1.5,
    crossAxisCount: 1,
  );
}
