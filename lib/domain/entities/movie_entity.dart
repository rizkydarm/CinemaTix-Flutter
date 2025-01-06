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

class SelectedDateTimeBookingEntity extends Entity {

  final String date;
  final String time;

  SelectedDateTimeBookingEntity({
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [date, time]; 
}

class SelectedSeatsEntity extends Entity {

  final int total;
  final List<(int, int)> positions;

  SelectedSeatsEntity({
    required this.total,
    required this.positions,
  });

  @override
  List<Object?> get props => [total, positions]; 
}

class SelectedCityCinemaMallEntity extends Entity {

  final CityEntity city;
  final CinemaMallEntity cinemaMall;

  SelectedCityCinemaMallEntity({
    required this.city,
    required this.cinemaMall,
  });

  @override
  List<Object?> get props => [city, cinemaMall]; 
}