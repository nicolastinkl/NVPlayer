import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/explore/explore_page.dart';
import 'package:movie_app/pages/home/home_page.dart';
import 'package:movie_app/pages/movies/movies_page.dart';
import 'package:movie_app/pages/mylist/my_list_page.dart';
import 'package:movie_app/pages/profile/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const MainPage());
  }
}

class _MainPageState extends State<MainPage> {
  var _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ExplorePage(),
    const MoviesPage(),
    const MyListPage(),
    const ProfilePage(),
  ];

  void _setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: _selectedIndex,
        onTap: _setIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const Icon(IconlyBold.home)
                : const Icon(IconlyLight.home),
            label: context.l10n.home,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(IconlyBold.discovery)
                : const Icon(IconlyLight.discovery),
            label: context.l10n.explore,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(IconlyBold.play)
                : const Icon(IconlyLight.play),
            label: context.l10n.movies,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(IconlyBold.bookmark)
                : const Icon(IconlyLight.bookmark),
            label: context.l10n.myList,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? const Icon(IconlyBold.profile)
                : const Icon(IconlyLight.profile),
            label: context.l10n.profile,
          )
        ],
      ),
    );
  }
}
