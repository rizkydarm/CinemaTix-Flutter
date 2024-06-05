part of '../_data.dart';

class MovieRepository {
  
  final MovieRemoteDataSource _remoteDataSource = MovieRemoteDataSource();

  Future<List<MovieEntity>> _fetchMovies(
    Future<List<MovieModel>> Function({int page, String? language}) fetchFunction,
    {int page = 1, String? language}
  ) async {
    final movies = await fetchFunction(page: page, language: language);
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

  Future<List<MovieEntity>> getPlayingNowMovies({int page = 1, String? language}) async {
    return _fetchMovies(_remoteDataSource.getPlayingNowMovies, page: page, language: language);
  }

  Future<List<MovieEntity>> getUpComingMovies({int page = 1, String? language}) async {
    return _fetchMovies(_remoteDataSource.getUpComingMovies, page: page, language: language);
  }

  Future<MovieDetailEntity> getMovieDetailById(String id) async {
    final movieDetail = await _remoteDataSource.getDetailMovie(id);
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

  Future<(List<MovieCrewEntity>, List<MovieCastEntity>)> getMovieCreditsById(String id) async {
    final (crews, casts) = await _remoteDataSource.getMovieCredits(id);
    
    final crewEntities = crews.map((e) => MovieCrewEntity(
      id: e.id!,
      gender: e.gender! == 1 ? 'Male' : 'Female',
      name: e.name!,
      originalName: e.originalName!,
      popularity: e.popularity!,
      profilePath: e.profilePath,
    )).toList();
    final castEntities = casts.map((e) => MovieCastEntity(
      id: e.id!,
      gender: e.gender! == 1 ? 'Male' : 'Female',
      name: e.name!,
      originalName: e.originalName!,
      popularity: e.popularity!,
      profilePath: e.profilePath,
    )).toList();

    return (crewEntities, castEntities);
  }
}
