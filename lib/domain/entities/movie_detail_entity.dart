part of '../_domain.dart';

class MovieDetailEntity extends Entity {
  final MovieEntity movie;
  final String backdropPath;
  final String productionCompanies;
  final double voteAverage;
  final double popularity;
  final String tagline;
  final DateTime _releaseDate;

  MovieDetailEntity({
    required this.movie,
    required this.backdropPath,
    required this.productionCompanies,
    required this.voteAverage,
    required this.popularity,
    required this.tagline,
    required DateTime releaseDate,
  }) : _releaseDate = releaseDate;

  String get releaseDate => DateFormat('dd MMMM yyyy').format(_releaseDate);

  @override
  List<Object?> get props => [
    movie, productionCompanies
  ];
}

