import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/app/auth_bloc/authentication_bloc.dart';
import 'package:movie_app/app/config_bloc/config_bloc.dart';
import 'package:movie_app/pages/initialpages/page/onboardingpage.dart';
// import 'package:movie_app/pages/initialpages/page/OnBoardingPage.dart';
import 'package:movie_app/pages/main/main_page.dart';
import 'package:movie_app/pages/splash/splash_screen.dart';
import 'package:movie_app/resources/app_theme.dart';

import 'package:movies_data/movies_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
/// [App.]
///  Main App
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, March 28th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class App extends StatefulWidget {
  final SharedPreferences sharedPref;
  final BoxCollection boxCollection;

  const App({super.key, required this.sharedPref, required this.boxCollection});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthRepository _authRepository;
  late final MoviesRepository _movieRepository;
  late final StorageRepository _storageRepository;
  late final ConfigRepository _configRepository;

  @override
  void initState() {
    _authRepository = AuthRepository(widget.sharedPref);
    _storageRepository = StorageRepository(widget.boxCollection);
    _configRepository = ConfigRepository(widget.sharedPref);
    _movieRepository = MoviesRepository();
    super.initState();
  }

  @override
  void dispose() {
    _authRepository.dispose();
    _storageRepository.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => _authRepository),
        RepositoryProvider<StorageRepository>(
            create: (_) => _storageRepository),
        RepositoryProvider<ConfigRepository>(create: (_) => _configRepository),
        RepositoryProvider<MoviesRepository>(create: (_) => _movieRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthenticationBloc(_authRepository)),
          BlocProvider(
              create: (_) =>
                  ConfigBloc(_configRepository)..add(GetInitialAppState())),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        ScreenUtil.init(context);
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkThemeData, //默认为黑暗主题
          darkTheme: AppTheme.darkThemeData,
          themeMode: state.darkTheme ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(state.langCode),
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.unknown:
                    _navigator.pushAndRemoveUntil<void>(
                        SplashPage.route(), (route) => false);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                        OnBoardingPage.route(), (route) => false);
                    // MainPage.route(),(route) => false);
                    break;
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                        // MainPage.route(), (route) => false);
                        OnBoardingPage.route(),
                        (route) => false);
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
        );
      },
    );
  }
}
