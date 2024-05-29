
part of '../_domain.dart';

class MovieUseCase {

  final MovieRepository repository;

  MovieUseCase(this.repository);

  Future<List<MovieEntity>> getPlayingNowMovies({int page = 1, String? language}) async {
    return await repository.getPlayingNowMovies(page: page, language: language);
  }

  Future<List<MovieEntity>> getUpComingMovies({int page = 1, String? language}) async {
    return await repository.getUpComingMovies(page: page, language: language);
  }

  Future<MovieDetailEntity> getMovieDetailById(String id) async {
    return await repository.getMovieDetailById(id);
  }
}