import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/app/app.dart';
import 'package:movie_app/common/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

void bootstrap({
  required SharedPreferences sharedPref,
  required BoxCollection boxCollection,
}) {
  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };
  // Bloc.observer = AppBlocObserver();
  runApp(App(sharedPref: sharedPref, boxCollection: boxCollection));
  // runApp(
  //   const MyApp(),
  // );
  // runZonedGuarded(
  //   () => ,
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}
