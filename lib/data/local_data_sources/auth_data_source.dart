part of '../_data.dart';

class AuthLocalDataSource implements LocalDataSource {

  SQLHelper? _sql;

  AuthLocalDataSource() {
    getit.getAsync<SQLHelper>().then((value) {
      _sql = value;
    }).whenComplete(() async {
      if (_sql == null) {
        throw Exception('SQLHelper is not initialized');
      }
      final isUserTableExist = await _sql!.isTableExists('user');
      if (!isUserTableExist) {
        await _sql!.createTable('user', [
          SQLColumn('id', SQLType.text, isPrimaryKey: true),
          SQLColumn('email', SQLType.text),
          SQLColumn('password', SQLType.text),
          SQLColumn('profile_id', SQLType.text),
        ]);
      }
      final isProfileExist = await _sql!.isTableExists('profile');
      if (!isProfileExist) {
        await _sql!.createTable('profile', [
          SQLColumn('id', SQLType.text, isPrimaryKey: true),
          SQLColumn('username', SQLType.text, canBeNull: true),
          SQLColumn('display_name', SQLType.text, canBeNull: true),
          SQLColumn('number_phone', SQLType.text, canBeNull: true),
          SQLColumn('avatar_url', SQLType.text, canBeNull: true),
        ]);
      }
    });
  }
  
  Future<UserModel> register(String email, String password) async {
    if (_sql == null) {
      throw Exception('SQLHelper is not initialized');
    }
    final profile = ProfileModel(id: const Uuid().v4());
    final user = UserModel(id: const Uuid().v4(), email: email, password: password, profile: profile);
    await _sql!.insert('user', user.toSQLJson());
    await _sql!.insert('profile', profile.toJson());
    return user;
  }

  Future<UserModel> login(String email, String password) async {
    if (_sql == null) {
      throw Exception('SQLHelper is not initialized');
    }
    final resultUser = await _sql!.query('user', where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (resultUser.isNotEmpty) {
      final user = UserModel.fromSQLJson(resultUser.first);
      final resultProfile = await _sql!.query('profile', where: 'id = ?', whereArgs: [user.profile?.id]);
      if (resultProfile.isNotEmpty) {
        user.profile?.copyWithModel(ProfileModel.fromJson(resultProfile.first));
        return user;
      }
      return user;
    } else {
      throw Exception('User is not found');
    }
  }
}