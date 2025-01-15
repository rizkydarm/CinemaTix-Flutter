part of '../_domain.dart';

class MovieEntity extends Entity {
  final String id;
  String? title;
  String? overview;
  String? posterPath;
  List<String>? genres;
  bool? isLiked;
  double? rating;

  MovieEntity({
    required this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.genres,
    this.rating,
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