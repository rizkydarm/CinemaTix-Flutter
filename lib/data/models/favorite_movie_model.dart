part of '../_data.dart';

class FavoriteMovieModel {
  final String? id;
  final String? userId;
  final String? movieId;

  FavoriteMovieModel({
    this.id,
    this.userId,
    this.movieId,
  });

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) {
    return FavoriteMovieModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      movieId: json['movie_id'] as String?,
    );
  }

  factory FavoriteMovieModel.fromSQLJson(Map<String, dynamic> json) {
    return FavoriteMovieModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      movieId: json['movie_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "movie_id": movieId,
  };

  Map<String, dynamic> toSQLJson() => {
    "id": id,
    "user_id": userId,
    "movie_id": movieId,
  };
}
