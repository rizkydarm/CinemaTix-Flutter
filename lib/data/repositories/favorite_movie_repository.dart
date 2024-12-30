part of '../_data.dart';

class FavoriteMovieRepository implements Repository {
  
  final FavoriteMovieLocalDataSource _localDataSource = getit.get<FavoriteMovieLocalDataSource>();

  Future<void> addFavoriteMovie(String userId, String movieId) async {
    return _localDataSource.insertFavoriteMovie(userId, movieId);
  }

  Future<List<FavoriteMovieEntity>> getUserFavoriteMovies(String userId) async {
    final result = await _localDataSource.getUserFavoriteMovies(userId);
    return result.map((data) => FavoriteMovieEntity(
      id: data.id!,
      movieId: data.movieId!,
    )).toList();
  }

  Future<void> removeFavoriteMovie(String userId, String movieId) async {
    return _localDataSource.removeFavoriteMovie(userId, movieId);
  }

}