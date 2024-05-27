part of '../_core.dart';

class TMDBApi {
  const TMDBApi._();

  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String keyAuth = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOTc4NmU2YzQwODg2MGQ1MjQzMzY2ZDU2ZjQ1NjVmYiIsInN1YiI6IjVmM2U3NmU0YzE3NWIyMDAzNjVjYWQyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m6-n_LC0tAyozYRn1U5dsKZ2SS1fJNjtrFpPU7AUg8g';

  static const Map<String, dynamic> headers = {
    'Authorization': TMDBApi.keyAuth,
    'accept': 'application/json'
  };
  
  Endpoint playingNow({int page = 1, String? language}) => Endpoint('movie/now_playing', 
    TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

  Endpoint popular({int page = 1, String? language}) => Endpoint('movie/popular', 
    TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

  Endpoint topRated({int page = 1, String? language}) => Endpoint('movie/top_rated', 
    TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

  Endpoint upComing({int page = 1, String? language}) => Endpoint('movie/upcoming', 
  TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

}