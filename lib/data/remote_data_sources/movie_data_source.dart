part of '../_data.dart';

class MovieRemoteDataSource {
  
  final DioHelper _dio = DioHelper(TMDBApi.baseUrl);

  MovieRemoteDataSource();

  Future<List<MovieModel>> getPlayingNowMovies({int page = 1, String? language}) async {
    final data = await _dio.get(TMDBApi.playingNow(page: page, language: language));
    return (data['results'] as List)
      .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
      .toList();
  }

  Future<List<MovieModel>> getUpComingMovies({int page = 1, String? language}) async {
    final data = await _dio.get(TMDBApi.upComing(page: page, language: language));
    return (data['results'] as List)
      .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
      .toList();
  }

  Future<MovieDetailModel> getDetailMovie(String id) async {
    final data = await _dio.get<Map>(TMDBApi.detailById(id));
    return MovieDetailModel.fromJson(data as Map<String, dynamic>);
  }
}
