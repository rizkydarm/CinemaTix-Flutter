part of '../_domain.dart';

class AuthUseCase {

  final AuthRepository _repository = getit.get<AuthRepository>();

  Future<UserEntity> register(String email, String password) async {
    return await _repository.register(email, password);
  }

  Future<UserEntity> login(String email, String password) async {
    return await _repository.login(email, password);
  }

  Future<void> logout() async {
    await _repository.logout();
  }

  Future<UserEntity> getUser() async {
    return await _repository.getUser();
  }

  Future<UserEntity> signInWithGoogle() async {
    return await _repository.signInWithGoogle();
  }
}