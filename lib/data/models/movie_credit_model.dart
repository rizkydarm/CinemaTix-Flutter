part of '../_data.dart';

class MovieCastModel {
    bool? adult;
    int? gender;
    String? id;
    String? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;
    int? castId;
    String? character;
    String? creditId;
    int? order;

    MovieCastModel({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
    });

    factory MovieCastModel.fromJson(Map<String, dynamic> json) => MovieCastModel(
        adult: json["adult"],
        gender: json["gender"],
        id: (json["id"] as num).toString(),
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
    };
}

class MovieCrewModel {
    bool? adult;
    int? gender;
    String? id;
    String? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;
    String? creditId;
    String? department;
    String? job;

    MovieCrewModel({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.creditId,
        this.department,
        this.job,
    });

    factory MovieCrewModel.fromJson(Map<String, dynamic> json) => MovieCrewModel(
        adult: json["adult"],
        gender: json["gender"],
        id: (json["id"] as num).toString(),
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        creditId: json["credit_id"],
        department: json["department"],
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "credit_id": creditId,
        "department": department,
        "job": job,
    };
}
