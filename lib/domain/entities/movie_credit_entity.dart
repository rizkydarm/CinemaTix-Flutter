part of '../_domain.dart';

class MovieCastEntity extends Entity {
    final String id;
    final String gender;
    final String name;
    final String originalName;
    final double popularity;
    final String? profilePath;
    
    MovieCastEntity({
      required this.gender,
      required this.id,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
    });

    @override
    List<Object?> get props => [
      id,
      gender,
    ];
}

class MovieCrewEntity extends Entity {
    
    final String id;
    final String gender;
    final String name;
    final String originalName;
    final double popularity;
    final String? profilePath;
    
    MovieCrewEntity({
      required this.gender,
      required this.id,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
    });

    @override
    List<Object?> get props => [
      id,
      gender,
    ];
}
