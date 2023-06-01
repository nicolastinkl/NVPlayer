import 'package:storage_api/src/models/movie_item_entity.dart';

abstract class FavoritesStorageApi {
  /// {@macro storage_api}
  const FavoritesStorageApi();

  /// Provides a [Stream] of all movies.
  Stream<List<MovieItemEntity>> getMovies();

  /// Saves a [movie].
  ///
  /// If a [movie] with the same id already exists, it will be replaced.
  Future<void> saveMovie(MovieItemEntity movie);

  /// Deletes the movie with the given id.
  ///
  /// If no movie with the given id exists, a [MovieNotFoundException] error is
  /// thrown.
  Future<void> deleteMovie(String id);

  /// Deletes all movies.
  ///
  /// Returns nothing.
  Future<void> clearAll();

  /// check movie by id
  ///
  Future<bool> checkWhetherIsMarkedOrNot(String id);

  void close();
}

class MovieNotFoundException implements Exception {}
