part of '../_data.dart';

class MovieRemoteDataSource {
  
  final DioHelper _dio = getit.get<DioHelper>(param1: TMDBApi.baseUrl);

  Future<List<MovieModel>> getSearchedMovies(String query, {int page = 1, String? language}) async {
    final data = await _dio.get<Map>(TMDBApi.searchedMovie(query, page: page, language: language));
    if (data?.containsKey('results') ?? false) {
      return (data?['results'] as List? ?? [])
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
    } else {
      throw Exception('Results key is not found in playingNow data');
    }
  }

  Future<List<MovieModel>> getPlayingNowMovies({int page = 1, String? language}) async {
    final data = await _dio.get<Map>(TMDBApi.playingNow(page: page, language: language));
    if (data?.containsKey('results') ?? false) {
      return (data?['results'] as List? ?? [])
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
    } else {
      throw Exception('Results key is not found in playingNow data');
    }
  }

  Future<List<MovieModel>> getUpComingMovies({int page = 1, String? language}) async {
    final data = await _dio.get<Map>(TMDBApi.upComing(page: page, language: language));
    if (data?.containsKey('results') ?? false) {
      return (data?['results'] as List)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
    } else {
      throw Exception('Results key is not found in upComing data');
    }
  }

  Future<MovieDetailModel> getDetailMovie(String id) async {
    final data = await _dio.get<Map>(TMDBApi.detailById(id));
    return MovieDetailModel.fromJson(data as Map<String, dynamic>);
  }

  Future<(List<MovieCrewModel>, List<MovieCastModel>)> getMovieCredits(String id) async {
    final data = await _dio.get<Map>(TMDBApi.movieCredits(id));
    
    if ((data?.containsKey('crew') ?? false) && (data?.containsKey('cast') ?? false)) {
      final crews = (data?['crew'] as List)
        .map((e) => MovieCrewModel.fromJson(e as Map<String, dynamic>))
        .toList();
      final casts = (data?['cast'] as List)
        .map((e) => MovieCastModel.fromJson(e as Map<String, dynamic>))
        .toList();
      return (crews, casts);
    } else {
      throw Exception('Crew key is not found in movieCredits data');
    }
  }
}
