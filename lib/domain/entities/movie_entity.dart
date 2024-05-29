part of '../_domain.dart';

class MovieEntity extends Entity {
  final String id;
  final String title;
  final String overview;
  final String posterPath;
  final List<String> genres;
  final bool isLiked;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.genres,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [
    id, title
  ];
}

