part of '../_domain.dart';

class MovieEntity extends Entity {
  final String id;
  final String title;
  final String overview;
  final String posterPath;
  final List<String> genres;
  final bool isLiked;
  final double rating;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.genres,
    required this.rating,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [
    id, title
  ];
}

