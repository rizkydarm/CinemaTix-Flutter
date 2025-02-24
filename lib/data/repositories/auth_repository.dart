part of '../_data.dart';

abstract class AuthRepositoryAbs implements Repository {
  Future<UserEntity> register(String email, String password);
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signInWithGoogle();
  Future<void> logout();
  Future<UserEntity> getUser();
}

class AuthRepository implements AuthRepositoryAbs {
  
  final AuthLocalDataSource _localDataSource = getit.get<AuthLocalDataSource>();
  final FirebaseAuthDataSource _firebaseAuthDataSource = getit.get<FirebaseAuthDataSource>();

  @override
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

  @override
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

  @override
  Future<void> logout() async {
    await _localDataSource.removeUser();
  }

  @override
  Future<UserEntity> getUser() async {
    final model = await _localDataSource.getUser();
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

  @override
  Future<UserEntity> signInWithGoogle() async {
    final userCredential = await _firebaseAuthDataSource.signInWithGoogle();
    final user = userCredential.user;
    final userEntity = UserEntity(
      id: user!.uid,
      email: user.email!,
      profile: ProfileEntity(
        id: const Uuid().v4(),
      )
    );
    _localDataSource.saveUser(UserModel(
      id: user.uid,
      email: user.email!,
      password: '',
      profile: ProfileModel(
        id: userEntity.profile.id,
      ),
    ));
    return userEntity;
  }
}

class DummyAuthRepository implements AuthRepositoryAbs {
  @override
  Future<UserEntity> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
  @override
  Future<UserEntity> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
  
}