import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/bootstrap.dart';
import 'package:movie_app/common/global.dart';
import 'package:movie_app/http/http_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const databaseName = 'movies.db';
const collectionFavorites = 'favorites.box';
const collectionGenres = 'genres.box';

Future<void> main() async {
  //Init Main URL
  HttpUtils.init(
    baseUrl: Global.baseUrl,
  );

  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();
  Directory directory = Directory("/assets/db");
  if (kIsWeb) {
  } else {
    final path = await getApplicationDocumentsDirectory();
    directory = path;
  }

  final boxCollection = await BoxCollection.open(
    databaseName,
    {collectionFavorites, collectionGenres},
    path: directory.path,
  );

  bootstrap(sharedPref: sharedPrefs, boxCollection: boxCollection);
}
