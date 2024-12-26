part of '../_data.dart';

class AuthRepository implements Repository {
  
  final AuthLocalDataSource _localDataSource = getit.get<AuthLocalDataSource>();

  Future<UserEntity> register(String email, String password) async {
    final model = await _localDataSource.register(email, password);
    return UserEntity(
      id: model.id!, 
      email: model.email!, 
      profile: ProfileEntity(
        id: model.profile!.id!,
      )
    );
  }

  Future<UserEntity> login(String email, String password) async {
    final model = await _localDataSource.login(email, password);
    return UserEntity(
      id: model.id!, 
      email: model.email!, 
      profile: ProfileEntity(
        id: model.profile!.id!,
        username: model.profile?.username,
        displayName: model.profile?.displayName,
        numberPhone: model.profile?.numberPhone,
        avatarUrl: model.profile?.avatarUrl,
      )
    );
  }
}