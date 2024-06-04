part of '../../_core.dart';

class MyApi {
  const MyApi._();

  static const String baseUrl = 'http://localhost:8080/';
  static const String keyAuth = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOTc4NmU2YzQwODg2MGQ1MjQzMzY2ZDU2ZjQ1NjVmYiIsInN1YiI6IjVmM2U3NmU0YzE3NWIyMDAzNjVjYWQyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m6-n_LC0tAyozYRn1U5dsKZ2SS1fJNjtrFpPU7AUg8g';

  static const Map<String, dynamic> headers = {
    'Authorization': 'Bearer $keyAuth',
    'accept': 'application/json'
  };
  
  Endpoint likedMovies() => const Endpoint('likedMovies', 
    TMDBApi.headers, params: {
      'page': 100,
      'checkDulu': true
    }
  );
}