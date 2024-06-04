
part of '../_domain.dart';

class MovieUseCase {

  final MovieRepository _repository = MovieRepository();

  Future<List<MovieEntity>> getPlayingNowMovies({int page = 1, String? language}) async {
    return await _repository.getPlayingNowMovies(page: page, language: language);
  }

  Future<List<MovieEntity>> getUpComingMovies({int page = 1, String? language}) async {
    return await _repository.getUpComingMovies(page: page, language: language);
  }

  Future<MovieDetailEntity> getMovieDetailById(String id) async {
    return await _repository.getMovieDetailById(id);
  }
}