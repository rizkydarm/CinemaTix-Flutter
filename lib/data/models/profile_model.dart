part of '../_data.dart';

class ProfileModel {
  final String? id;
  final String? username; 
  final String? displayName;
  final String? numberPhone;
  final String? avatarUrl;

  ProfileModel({
    this.id,
    this.username,
    this.displayName,
    this.numberPhone,
    this.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String?,
      username: json['username'] as String?,
      displayName: json['display_name'] as String?,
      numberPhone: json['number_phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "display_name": displayName,
    "number_phone": numberPhone,
    "avatar_url": avatarUrl,
  };

  ProfileModel copyWith({
    String? id,
    String? username,
    String? displayName,
    String? numberPhone,
    String? avatarUrl,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      numberPhone: numberPhone ?? this.numberPhone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  ProfileModel copyWithModel(ProfileModel profile) {
    return ProfileModel(
      id: profile.id ?? id,
      username: profile.username ?? username,
      displayName: profile.displayName ?? displayName,
      numberPhone: profile.numberPhone ?? numberPhone,
      avatarUrl: profile.avatarUrl ?? avatarUrl,
    );
  }

}