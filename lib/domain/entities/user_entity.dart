part of '../_domain.dart';


class UserEntity extends Entity {
  final String id;
  final String email;
  final ProfileEntity profile;

  UserEntity({
    required this.id,
    required this.email,
    required this.profile,
  });

  @override
  List<Object?> get props => [id, email, profile];
}