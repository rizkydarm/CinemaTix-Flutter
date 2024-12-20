part of '../_domain.dart';


class CinemaMallEntity extends Entity {
  final String mall;
  final String cinema;
  final List<String> times;

  CinemaMallEntity({required this.mall, required this.cinema, required this.times});

  @override
  List<Object?> get props => [
    mall,
    cinema,
    times.toString()
  ];
}

class CityEntity extends Entity {
  final String id;
  final String name;

  CityEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
    id,
    name,
  ];

}
