part of '../_data.dart';

class MovieRepository {
  
  final MovieRemoteDataSource remoteDataSource;

  MovieRepository(this.remoteDataSource);

  Future<List<MovieEntity>> getPlayingNowMovies({int page = 1, String? language}) async {
    final movies = await remoteDataSource.getPlayingNowMovies(page: page, language: language);
    return movies.map((e) => MovieEntity(
      id: e.id!,
      title: e.title!,
      overview: e.overview!,
      posterPath: e.posterPath!,
      genres: e.genreIds!
        .map((id) => TMDBApi.genreIds.firstWhere(
          (genre) => genre['id'] == id
        )['name'] as String).toList(),
    )).toList();
  }

  Future<List<MovieEntity>> getUpComingMovies({int page = 1, String? language}) async {
    final movies = await remoteDataSource.getPlayingNowMovies(page: page, language: language);
    return movies.map((e) => MovieEntity(
      id: e.id!,
      title: e.title!,
      overview: e.overview!,
      posterPath: e.posterPath!,
      genres: e.genreIds!
        .map((id) => TMDBApi.genreIds.firstWhere(
          (genre) => genre['id'] == id
        )['name'] as String).toList(),
    )).toList();
  }

  Future<MovieDetailEntity> getMovieDetailById(String id) async {
    final movieDetail = await remoteDataSource.getDetailMovie(id);
    return MovieDetailEntity(
      movie: MovieEntity(
        id: movieDetail.id!,
        title: movieDetail.title!,
        overview: movieDetail.overview!,
        posterPath: movieDetail.posterPath!,
        genres: movieDetail.genres!
          .map((genre) => genre.name!).toList(),
      ), 
      backdropPath: movieDetail.backdropPath!, 
      productionCompanies: movieDetail.productionCompanies!
        .map((e) => e.name!).toList().first, 
      voteAverage: movieDetail.voteAverage!, 
      popularity: movieDetail.popularity!, 
      tagline: movieDetail.tagline!,
      releaseDate: movieDetail.releaseDate!
    );
  }
}
