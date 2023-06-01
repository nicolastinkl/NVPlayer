import 'dart:math';

import 'package:movies_api/movies_api.dart';
import 'package:http/http.dart' as http;
import 'package:movies_api/src/models/cast/Cast_response.dart';
import 'package:movies_api/src/models/category/category.dart';
import 'dart:convert' as convert;

import 'package:movies_api/src/models/genre/genres.dart';
import 'package:movies_api/src/models/navi/navilist.dart';
import 'package:movies_data/movies_data.dart';

import 'package:movies_api/src/models/navi/navi_newest.dart';

const base_url = 'api.themoviedb.org';
const globle_url = 'api.dcgvc.com';

extension Logger<T> on Uri {
  void logging() {
    logger(this.toString());
  }

  void logger(String string) {}
}

/***
 * All Reqeust Impl
 */
class MovieApiServiceImpl extends MovieApi {
  @override
  Future<MoviesResponse> getMovieByType({
    required String type,
    required int page,
    String language = 'en-US',
  }) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
      'page': '$page',
    };
    var url = Uri.https(base_url, '/3/movie/$type', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MoviesResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<MoviesResponse> getSimilarMovies({
    required String movieId,
    int? page,
    String language = 'en-US',
  }) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(base_url, '/3/movie/$movieId/similar', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MoviesResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<MoviesResponse> discoverMovies({
    required int page,
    String? genreId,
    String? language,
    String? year,
  }) async {
    var queries = {
      'api_key': '$apiKey',
      'language': '$language',
      'with_genres': '$genreId',
      'year': '$year',
      'page': '$page',
    };
    var url = Uri.https(base_url, '/3/discover/movie', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MoviesResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<MoviesResponse> getMoviesByQuery({
    String? query,
    required int page,
    String language = 'us-US',
  }) async {
    var queries = {
      'api_key': apiKey,
      'query': query,
      'include_adult': 'false',
      'language': language,
      'page': '$page',
    };
    var url = Uri.https(base_url, '/3/search/movie', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MoviesResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<NaviNewestItem> getMovieDetailNew({
    required String movieId,
    String language = 'en-US',
  }) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
      'movieId': movieId,
    };
    var url = Uri.https(globle_url, '/flutter/api/getmoivedes.php', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return NaviNewestItem.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail({
    required String movieId,
    String language = 'en-US',
  }) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(base_url, '/3/movie/$movieId', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MovieDetailResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<Genres> getAllGenres({String language = 'en-US'}) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(base_url, '/3/genre/movie/list', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Genres.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

/**
 *  Get all Category with new/hot/china/ja
 */
  @override
  Future<List<Categroy_Home>> getAllCategory(
      {String language = 'en-US'}) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(globle_url, '/flutter/api/getallcategiry.php', queries);
    url.logging();
    var response = await http.post(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;

      List<Categroy_Home> resultList = json["data"] == null
          ? []
          : List<Categroy_Home>.from(
              json["data"]!.map((x) => Categroy_Home.fromJson(x)));

      return resultList;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<VideosResponse> getVideoDataById({
    required String movieId,
    String language = 'us-US',
  }) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(base_url, '/3/movie/$movieId/videos', queries);
    url.logging();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return VideosResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<CastResponse> getCastByMovieId({
    required String movieId,
    String language = 'us-US',
  }) async {
    var queries = {'api_key': apiKey, 'language': language};
    final url = Uri.https(base_url, '/3/movie/$movieId/credits', queries);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return CastResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  ///根据ID获取所有信息板块
  @override
  Future<List<dynamic>> getAllNaviList(
      {String language = 'us-US', required String naviId}) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
      'naviId': naviId,
    };
    var url = Uri.https(globle_url, '/flutter/api/homedata.php', queries);
    url.logging();
    var response = await http.post(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return json["page_data"] == null ? [] : json["page_data"];
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<List<dynamic>> getMoviesByNewest(
      {required int page, required String navireskey}) async {
    var queries = {
      'api_key': apiKey,
      'page': '$page',
      'navbar_id': navireskey,
    };
    var url = Uri.https(globle_url, '/flutter/api/newestdata.php', queries);
    url.logging();
    var response = await http.post(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return json["data"] == null ? [] : json["data"];
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<List<dynamic>> getTabDataByCateResKey(
      {String language = "zh-cn", required String navireskey}) async {
    var queries = {
      'api_key': apiKey,
      'language': language,
      'navbar_id': navireskey,
    };
    var url =
        Uri.https(globle_url, '/flutter/api/gettabdatabycate.php', queries);
    url.logging();
    var response = await http.post(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return json["data"] == null ? [] : json["data"];
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }
}

class UnauthorizedException implements Exception {}

class FailedException implements Exception {
  final String message;

  FailedException({this.message = 'Something went wrong!'});
}
