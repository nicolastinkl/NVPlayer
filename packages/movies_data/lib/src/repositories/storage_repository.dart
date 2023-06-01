import 'package:hive/hive.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_data/src/api/favorites_storage_api_impl.dart';
import 'package:movies_data/src/api/genres_storage_api_impl.dart';
import 'package:storage_api/storage_api.dart';

const collectionFavorites = 'favorites.box';
const collectionGenres = 'genres.box';

class StorageRepository {
  final FavoritesStorageApi _favoritesStorage;
  final GenresStorageApi _genresStorage;

  StorageRepository(BoxCollection boxCollection)
      : this._favoritesStorage = FavoritesStorageApiImpl(
          boxCollection: boxCollection,
          collectionName: collectionFavorites,
        ),
        this._genresStorage = GenresStorageApiImpl(
          boxCollection: boxCollection,
          collectionName: collectionGenres,
        );

  /// Provides a [Stream] of all movies.
  Stream<List<MovieItem>> getSavedMovies() => _favoritesStorage.getMovies().map(
        (list) => list.map((movie) => MovieItem.fromStorage(movie)).toList(),
      );

  /// Provides a [Stream] of all genres.
  Stream<List<GenreItem>> getSavedGenres() =>
      _genresStorage.getGenres().map((set) => set
          .map((e) => GenreItem(id: e.id, name: e.name, isActive: e.isActive))
          .toList());

  /// Provides a [Stream] of active genres.
  Stream<List<GenreItem>> getActiveGenres() =>
      _genresStorage.getGenres().map((set) => set
          .map((e) => GenreItem(id: e.id, name: e.name, isActive: e.isActive))
          .where((e) => e.isActive)
          .toList());

  /// Saves a [movie].
  Future<void> saveMovies(MovieItem movie) => _favoritesStorage.saveMovie(
        MovieItemEntity(
          id: movie.id,
          posterPath: movie.posterPath,
          title: movie.title,
          rating: movie.rate,
          backdropPath: movie.backdropPath,
        ),
      );

  /// Saves [List] of genres.
  Future<void> saveListOfGenres(Set<GenreItem> genres) =>
      _genresStorage.saveListOfGenres(
        {...genres.map((e) => GenreEntity(name: e.name, id: e.id))},
      );

  Future<void> changeGenreFlag(GenreItem genre) async {
    _genresStorage.changeFlag(
        GenreEntity(name: genre.name, id: genre.id, isActive: genre.isActive));
  }

  /// Deletes the movie with the given id.
  /// If no movie with the given id exists, a [MovieNotFoundException] error is
  /// thrown.
  Future<void> deleteMovie(String movieId) =>
      _favoritesStorage.deleteMovie(movieId);

  /// Deletes the genre with the given id.
  /// If no genre with the given id exists, a [IterableElementError] error is
  /// thrown.
  Future<void> deleteGenre(String id) => _genresStorage.deleteGenre(id);

  Future<void> clearAllMovies() => _favoritesStorage.clearAll();

  Future<void> clearAllGenres() => _genresStorage.clearGenre();

  Future<bool> checkWhetherIsMarkedOrNot(String movieId) =>
      _favoritesStorage.checkWhetherIsMarkedOrNot(movieId);

  void close() {
    _genresStorage.close();
    _favoritesStorage.close();
  }
}
