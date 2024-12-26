part of '../_data.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? password;
  final ProfileModel? profile;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      profile: json['profile'] == null ? null : ProfileModel.fromJson(json['profile']),
    );
  }

  factory UserModel.fromSQLJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      profile: json['profile_id'] == null ? null : ProfileModel(id: json['profile_id'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "profile": profile?.toJson(),
  };

  Map<String, dynamic> toSQLJson() => {
    "id": id,
    "email": email,
    "password": password,
    "profile_id": profile?.id,
  };
}