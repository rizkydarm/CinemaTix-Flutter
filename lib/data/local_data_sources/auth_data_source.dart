part of '../_data.dart';

class AuthLocalDataSource implements LocalDataSource {

  final SQLHelper _sql = getit.get<SQLHelper>();
  final SharedPrefHelper _sharedPref = getit.get<SharedPrefHelper>();

  AuthLocalDataSource() {
    
    _sql.isTableExists('user').then((isUserTableExist) {
      if (!isUserTableExist) {
        _createUserTable();
      }
    });
    _sql.isTableExists('profile').then((isProfileExist) {
      if (!isProfileExist) {
        _createProfileTable();
      }
    });
  }

  Future<void> _createProfileTable() async {
    await _sql.createTable('profile', [
      SQLColumn('id', SQLType.text, isPrimaryKey: true),
      SQLColumn('username', SQLType.text, canBeNull: true),
      SQLColumn('display_name', SQLType.text, canBeNull: true),
      SQLColumn('number_phone', SQLType.text, canBeNull: true),
      SQLColumn('avatar_url', SQLType.text, canBeNull: true),
    ]);
  }

  Future<void> _createUserTable() async {
    await _sql.createTable('user', [
      SQLColumn('id', SQLType.text, isPrimaryKey: true),
      SQLColumn('email', SQLType.text),
      SQLColumn('password', SQLType.text),
      SQLColumn('profile_id', SQLType.text),
    ]);
  }
  
  Future<UserModel> register(String email, String password) async {
    if (await isUserRegistered(email)) {
      throw Exception('User is already registered');
    }
    final profile = ProfileModel(id: const Uuid().v4());
    final user = UserModel(id: const Uuid().v4(), email: email, password: password, profile: profile);
    await _saveUser(user);
    await _sql.insert('user', user.toSQLJson());
    await _sql.insert('profile', profile.toJson());
    return user;
  }

  Future<UserModel> login(String email, String password) async {
    final resultUser = await _sql.query('user', where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (resultUser.isNotEmpty) {
      final user = UserModel.fromSQLJson(resultUser.first);
      final resultProfile = await _sql.query('profile', where: 'id = ?', whereArgs: [user.profile?.id]);
      if (resultProfile.isNotEmpty) {
        user.profile?.copyWithModel(ProfileModel.fromJson(resultProfile.first));
      }
      await _saveUser(user);
      return user;
    } else {
      throw Exception('User is not found');
    }
  }

  Future<void> _saveUser(UserModel user) async {
    await _sharedPref.setMap('user', user.toJson());  
  }

  Future<void> removeUser() async {
    await _sharedPref.removeMap('user');
  }

  Future<UserModel> getUser() async {
    final userJson = await _sharedPref.getMap('user');
    return UserModel.fromJson(userJson);
  }

  Future<bool> isUserRegistered(String email) async {
    final userJson = await _sql.query('user', where: 'email = ?', whereArgs: [email]);
    return userJson.isNotEmpty;
  }
}