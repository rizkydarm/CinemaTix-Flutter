part of '../_domain.dart';

class SearchedMovieEntity extends Entity {
  final String id;
  final String title;
  final List<String> genres;

  SearchedMovieEntity({
    required this.id,
    required this.title,
    required this.genres,
  });

  @override
  List<Object?> get props => [
    id, title
  ];
}

