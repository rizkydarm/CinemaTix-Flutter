import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:uuid/uuid.dart';

import '../data/entities.dart';

Response onRequest(RequestContext context) {
  
  final request = context.request;
  final method = request.method.value;
  final headers = request.headers;
  final params = request.uri.queryParameters;

  print(method);
  print(headers);
  print(params);

  final likedMovies = [
    LikedMovieEntity(id: 123, movieID: '653346', isLiked: true),
    LikedMovieEntity(id: 1234, movieID: '929590', isLiked: true),
    LikedMovieEntity(id: 124, movieID: '823464', isLiked: true),
  ];

  return Response(
    body: likedMovies.map(
      (e) => jsonEncode(e.toJson()),
    ).toString(),
  );
}
