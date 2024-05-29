part of '../../_core.dart';

class TMDBApi {

  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String keyAuth = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOTc4NmU2YzQwODg2MGQ1MjQzMzY2ZDU2ZjQ1NjVmYiIsInN1YiI6IjVmM2U3NmU0YzE3NWIyMDAzNjVjYWQyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m6-n_LC0tAyozYRn1U5dsKZ2SS1fJNjtrFpPU7AUg8g';

  static const Map<String, dynamic> headers = {
    'Authorization': 'Bearer ${TMDBApi.keyAuth}',
    'accept': 'application/json'
  };

  static Endpoint detailById(String id, {String? language}) => Endpoint('movie/$id', 
    TMDBApi.headers, params: (language != null) ? {
      'language': language
    } : null
  );
  
  static Endpoint playingNow({int page = 1, String? language}) => Endpoint('movie/now_playing', 
    TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

  static Endpoint popular({int page = 1, String? language}) => Endpoint('movie/popular', 
    TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

  static Endpoint topRated({int page = 1, String? language}) => Endpoint('movie/top_rated', 
    TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

  static Endpoint upComing({int page = 1, String? language}) => Endpoint('movie/upcoming', 
  TMDBApi.headers, params: {
      'page': page,
      if (language != null) 'language': language
    }
  );

  static const List<Map<String, dynamic>> genreIds = [
    {
      "id": 28,
      "name": "Action"
    },
    {
      "id": 12,
      "name": "Adventure"
    },
    {
      "id": 16,
      "name": "Animation"
    },
    {
      "id": 35,
      "name": "Comedy"
    },
    {
      "id": 80,
      "name": "Crime"
    },
    {
      "id": 99,
      "name": "Documentary"
    },
    {
      "id": 18,
      "name": "Drama"
    },
    {
      "id": 10751,
      "name": "Family"
    },
    {
      "id": 14,
      "name": "Fantasy"
    },
    {
      "id": 36,
      "name": "History"
    },
    {
      "id": 27,
      "name": "Horror"
    },
    {
      "id": 10402,
      "name": "Music"
    },
    {
      "id": 9648,
      "name": "Mystery"
    },
    {
      "id": 10749,
      "name": "Romance"
    },
    {
      "id": 878,
      "name": "Science Fiction"
    },
    {
      "id": 10770,
      "name": "TV Movie"
    },
    {
      "id": 53,
      "name": "Thriller"
    },
    {
      "id": 10752,
      "name": "War"
    },
    {
      "id": 37,
      "name": "Western"
    }
  ];

}