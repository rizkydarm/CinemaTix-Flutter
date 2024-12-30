part of '../_domain.dart';

class FavoriteMovieUseCase {

  final FavoriteMovieRepository _repository = getit.get<FavoriteMovieRepository>();

  Future<List<FavoriteMovieEntity>> getAllFavoriteMovies(String userId) async {
    return await _repository.getUserFavoriteMovies(userId);
  }

  Future<void> addFavoriteMovie(String userId, String movieId) async {
    return await _repository.addFavoriteMovie(userId, movieId);
  }

  Future<void> removeFavoriteMovie(String userId, String movieId) async {
    return await _repository.removeFavoriteMovie(userId, movieId);
  }
}