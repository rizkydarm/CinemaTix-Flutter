part of '../_domain.dart';

class FavoriteMovieEntity extends Entity {
  final String id;
  final String movieId;

  FavoriteMovieEntity({
    required this.id,
    required this.movieId,
  });

  @override
  List<Object?> get props => [
    id, movieId
  ];
}

