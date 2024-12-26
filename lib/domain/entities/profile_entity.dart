part of '../_domain.dart';


class ProfileEntity extends Entity {
  final String id;
  String? username; 
  String? displayName;
  String? numberPhone;
  String? avatarUrl;

  ProfileEntity({
    required this.id,
    this.username,
    this.displayName,
    this.numberPhone,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, username, displayName, numberPhone, avatarUrl];
}