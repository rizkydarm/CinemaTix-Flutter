part of '../_domain.dart';

class MovieDetailEntity extends Entity {
  final MovieEntity movie;
  final String backdropPath;
  final String productionCompanies;
  final double voteAverage;
  final double popularity;
  final String tagline;
  final DateTime releaseDate;

  MovieDetailEntity({
    required this.movie,
    required this.backdropPath,
    required this.productionCompanies,
    required this.voteAverage,
    required this.popularity,
    required this.tagline,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
    movie, productionCompanies
  ];
}

