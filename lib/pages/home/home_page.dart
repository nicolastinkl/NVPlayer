import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/home_data.dart';
import 'package:movie_app/pages/home/tabs/home_tab_newest.dart';
import 'package:movie_app/pages/home/tabs/home_tab_others.dart';
import 'package:movie_app/pages/home/tabs/home_tab_recommend.dart';
import 'package:movie_app/pages/home/widgets/avtor_movices.dart';
import 'package:movie_app/pages/home/widgets/muti_movices.dart';
import 'package:movie_app/pages/home/widgets/now_playing_movies.dart';
import 'package:movie_app/pages/home/widgets/popular_movies.dart';
import 'package:movie_app/pages/home/widgets/summary_movices.dart';
import 'package:movie_app/pages/home/widgets/top_rated_movies.dart';
import 'package:movie_app/pages/home/widgets/upcoming_movies.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';

import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/category/category.dart';
import 'package:movie_app/utils/status.dart';

import 'package:movies_api/src/models/navi/navilist.dart';
import 'package:movies_api/src/models/navi/navi_banner.dart';
import 'package:movies_api/src/models/navi/navi_summary.dart';
import 'package:movies_api/src/models/navi/navi_avtor.dart';
import 'package:movies_api/src/models/navi/navi_mutisummary.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeView();
    /*return BlocProvider(
      create: (context) => HomeBloc(
        moviesRepository: repository(context),
      )..add(FetchUpcomingMoviesEvent()),
      // ..add(FetchNowPlayingMoviesEvent())
      // ..add(FetchPopularMoviesEvent())
      // ..add(FetchTopRatedMoviesEvent()),
      // ..add(FetchAllCategorysEvent()),
      child: const _HomeView(),
    );*/
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({Key? key}) : super(key: key);

/*
  /// Old Impl
  Widget getBody_Old(BuildContext context, Categroy_Home categroyHome) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      onRefresh: () async {
        context.read<HomeBloc>().add(FetchUpcomingMoviesEvent());
        // ..add(FetchNowPlayingMoviesEvent())
        // ..add(FetchPopularMoviesEvent())
        // ..add(FetchTopRatedMoviesEvent());
      },
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 175.0,
              child: UpcomingMovies(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: PopularMovies(size: 366),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: TopRatedMovies(size: 175),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 8),
          )
        ],
      ),
    );
  }*/

  @override
  State<StatefulWidget> createState() {
    return _MyCustomWidgetState();
  }
}

class _MyCustomWidgetState extends State<_HomeView>
    with SingleTickerProviderStateMixin {
  var _selectedIndex = 0;
  late TabController _tabController;
  static final List<Tab> myTabs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  void _setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // super.build(context); // 必须调用 super.build
    final json = home_tabs_data as Map<String, dynamic>;

    List<Categroy_Home> resultList = json["data"] == null
        ? []
        : List<Categroy_Home>.from(
            json["data"]!.map((x) => Categroy_Home.fromJson(x)));

    final List<Widget> tabbody =
        resultList.map((e) => getBody(context, e)).toList();

    // print(tabbody.length);
    var size = MediaQuery.of(context).size;

    var tabbar = TabBar(
      controller: _tabController,
      isScrollable: true,
      unselectedLabelColor: Color.fromARGB(255, 193, 193, 191),
      indicatorColor: Colors.white, //选中下划线的颜色
      indicatorSize: TabBarIndicatorSize.label, //选中下划线的长度
      labelColor: Colors.white,
      tabs: myTabs,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        _pageController.animateToPage(_currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
    );

    return SafeArea(
        child: DefaultTabController(
      initialIndex: 0,
      length: resultList.length,
      child: getBodyNew(context, resultList),
    ));

    return SizedBox(
      width: size.width,
      child: Stack(
        // index: _selectedIndex,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Scaffold(
              body: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0 && _currentIndex > 0) {
                    // 向右滑动
                    setState(() {
                      _currentIndex--;
                    });
                    _pageController.animateToPage(_currentIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  } else if (details.primaryVelocity! < 0 &&
                      _currentIndex < myTabs.length - 1) {
                    // 向左滑动
                    setState(() {
                      _currentIndex++;
                    });
                    _pageController.animateToPage(_currentIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
                child: IndexedStack(
                  index: _currentIndex,
                  children: tabbody,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: size.width,
              height: 40,
              child: Container(
                color: Color.fromARGB(141, 50, 49, 49), // 设置背景颜色
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    // Icon(
                    //   Icons.live_tv,
                    //   color: white.withOpacity(0.5),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: Center(
                            child: tabbar,
                          )),
                    ),
                    // Icon(
                    //   Icons.search,
                    //   size: 25,
                    //   color: white.withOpacity(0.5),
                    // ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ////删除
  Widget build222(BuildContext context) {
    final json = home_tabs_data as Map<String, dynamic>;

    List<Categroy_Home> resultList = json["data"] == null
        ? []
        : List<Categroy_Home>.from(
            json["data"]!.map((x) => Categroy_Home.fromJson(x)));

    return DefaultTabController(
      initialIndex: 0,
      length: resultList.length,
      child: getBodyNew(context, resultList),
    );
  }

  final PageStorageBucket _bucket = PageStorageBucket();

  Widget getBodyNew(BuildContext context, List<Categroy_Home> lists) {
    List<Tab> tablist = [];
    // lists.map((e) => Tab(child: Text(e.navbarName ?? "")).toList();
    for (var element in lists) {
      Tab tab = Tab(
          child: Text(element.navbarName ?? "",
              style: const TextStyle(
                fontSize: 14, // 可以根据需要设置不同的字体大小
              )));

      // Tab(child: Text(element.navbarName ?? "");
      tablist.add(tab);
    }

    final List<Widget> tabbody = lists.map((e) => getBody(context, e)).toList();

    // print(tabbody.length);
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Stack(
        // index: _selectedIndex,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: PageStorage(
              bucket: _bucket,
              child: TabBarView(
                children: tabbody,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: size.width,
              height: 40,
              child: Container(
                color: Color.fromARGB(141, 50, 49, 49), // 设置背景颜色
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    // Icon(
                    //   Icons.live_tv,
                    //   color: white.withOpacity(0.5),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: Center(
                            child: TabBar(
                              isScrollable: true,
                              unselectedLabelColor:
                                  Color.fromARGB(255, 193, 193, 191),
                              indicatorColor: Colors.white, //选中下划线的颜色
                              indicatorSize:
                                  TabBarIndicatorSize.label, //选中下划线的长度
                              labelColor: Colors.white,
                              tabs: tablist,
                            ),
                          )),
                    ),
                    // Icon(
                    //   Icons.search,
                    //   size: 25,
                    //   color: white.withOpacity(0.5),
                    // ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody(BuildContext context, Categroy_Home categroyHome) {
    //推荐Tab页面
    if (categroyHome.navbarName == "最新") {
      return HomeTabNeweat(
        categroy_home: categroyHome,
      );
    } else if (categroyHome.navbarName == "推荐") {
      return HomeTabRecommend(
        categroy_home: categroyHome,
      );
    } else {
      return HomeTabOthers(
        categroy: categroyHome,
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; // 返回true，保留状态
}
/*
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: getBody(),
    );
  }

  
}
*/
