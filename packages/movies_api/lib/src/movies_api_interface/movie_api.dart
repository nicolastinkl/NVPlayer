import 'package:movies_api/src/models/cast/Cast_response.dart';
import 'package:movies_api/src/models/category/category.dart';
import 'package:movies_api/src/models/genre/genres.dart';
import 'package:movies_api/src/models/models.dart';
import 'package:movies_api/src/models/navi/navi_newest.dart';
import 'package:movies_api/src/models/navi/navilist.dart';

abstract class MovieApi {
  ///
  /// The interface for Movies that provides access to movies list
  Future<MoviesResponse> getMovieByType({
    required String type,
    String language,
    required int page,
  });

  ///
  /// Fetches similar movies by chosen movieId
  Future<MoviesResponse> getSimilarMovies({
    required String movieId,
    int? page,
    String language,
  });

  Future<MoviesResponse> discoverMovies({
    required int page,
    String? genreId,
    String? language,
    String? year,
  });

  /// Fetches movies by query.
  /// Function for searching
  Future<MoviesResponse> getMoviesByQuery({
    String? query,
    required int page,
    String language,
  });

  /// Fetches actors and producers by movie id returns [CastResponse]
  Future<CastResponse> getCastByMovieId(
      {required String movieId, String language});

  ///
  Future<NaviNewestItem> getMovieDetailNew({
    required String movieId,
    String language,
  });

  /// Fetches movie by ID
  Future<MovieDetailResponse> getMovieDetail({
    required String movieId,
    String language,
  });

  ///
  /// Fetches movie video path for youtube
  Future<VideosResponse> getVideoDataById({
    required String movieId,
    String language,
  });

  ///
  /// Fetches all genres
  Future<Genres> getAllGenres({
    String language,
  });

  ///
  /// Fetches all Category
  Future<List<Categroy_Home>> getAllCategory({
    String language,
  });

  ///
  /// Fetches all Category
  Future<List<dynamic>> getAllNaviList({
    String language,
    required String naviId,
  });

  //获取最新Videolist
  Future<List<dynamic>> getMoviesByNewest({
    required int page,
    required String navireskey,
  });

  // 分页获取Tab 根据标签名称
  Future<List<dynamic>> getTabDataByCateResKey({
    String language,
    required String navireskey,
  });
}
