part of '../../_core.dart';

class MyApi {
  const MyApi._();

  static const String baseUrl = 'http://localhost:8080/';
  static const String keyAuth = '';

  static const Map<String, dynamic> headers = {
    'Authorization': 'Bearer $keyAuth',
    'accept': 'application/json'
  };
  
  Endpoint likedMovies() => const Endpoint('likedMovies', 
    MyApi.headers, params: {
      'page': 100,
      'checkDulu': true
    }
  );
}