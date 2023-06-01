import 'package:storage_api/src/models/genre_entity.dart';

abstract class GenresStorageApi {
  const GenresStorageApi();

  /// Provides a [Stream] of all genres.
  Stream<Set<GenreEntity>> getGenres();

  /// Saves All genres from from user selection
  /// Receives [Set] of genres
  Future<void> saveListOfGenres(Set<GenreEntity> genres);

  /// Removes genre by id
  Future<void> deleteGenre(String id);

  /// change genre selection
  Future<void> changeFlag(GenreEntity genre);

  /// Removes all saved genres
  Future<void> clearGenre();

  void close();
}

class GenreNotFoundException implements Exception {}

