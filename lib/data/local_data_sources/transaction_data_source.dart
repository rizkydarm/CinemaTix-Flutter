part of '../_data.dart';

class TransactionDataSource implements LocalDataSource {

  final SQLHelper _sql = getit.get<SQLHelper>();
  // final SharedPrefHelper _sharedPref = getit.get<SharedPrefHelper>();

  TransactionDataSource() {
    _sql.isTableExists('user_transactions').then((isTableExist) {
      if (!isTableExist) {
        _createTransactionTable();
        
      }
    });
    // _sql.dropTable('user_transactions');
  }

  Future<void> _createTransactionTable() async {
    await _sql.createTable('user_transactions', [
      SQLColumn('id', SQLType.text, isPrimaryKey: true),
      SQLColumn('user_id', SQLType.text),
      SQLColumn('datetime', SQLType.text),
      SQLColumn('book_datetime', SQLType.text),
      SQLColumn('movie', SQLType.text),
      SQLColumn('status', SQLType.text, canBeNull: true),
      SQLColumn('seats', SQLType.text),
      SQLColumn('place', SQLType.text),
      SQLColumn('total_payment', SQLType.text, canBeNull: true),
      SQLColumn('payment_method', SQLType.text, canBeNull: true),
      SQLColumn('detail', SQLType.text, canBeNull: true),
    ]);
  }
  
  Future<void> add(TransactionModel model) async {
    await _sql.insert('user_transactions', model.toSQLJson()).onError((e, s) {
      getit.get<Talker>().handle(e!, s, 'TransactionDataSource.add');
    });
  }

  Future<List<TransactionModel>> fetchAllByUser(String userId) async {
    final result = await _sql.query('user_transactions',
      where: 'user_id = ?',
      whereArgs: [userId],
    ).onError((e, s) {
      getit.get<Talker>().handle(e!, s, 'TransactionDataSource.fetchAll');
      throw e;
    });
    return result.map((e) => TransactionModel.fromSQLJson(e)).toList();
  }

  // Future<UserModel> login(String email, String password) async {
  //   final resultUser = await _sql.query('user', where: 'email = ? AND password = ?', whereArgs: [email, password]);
  //   if (resultUser.isNotEmpty) {
  //     final user = UserModel.fromSQLJson(resultUser.first);
  //     final resultProfile = await _sql.query('profile', where: 'id = ?', whereArgs: [user.profile?.id]);
  //     if (resultProfile.isNotEmpty) {
  //       user.profile?.copyWithModel(ProfileModel.fromJson(resultProfile.first));
  //     }
  //     await _saveUser(user);
  //     return user;
  //   } else {
  //     throw Exception('User is not found');
  //   }
  // }

  // Future<void> _saveUser(UserModel user) async {
  //   await _sharedPref.setMap('user', user.toJson());  
  // }

  // Future<void> removeUser() async {
  //   await _sharedPref.removeMap('user');
  // }

  // Future<UserModel> getUser() async {
  //   final userJson = await _sharedPref.getMap('user');
  //   return UserModel.fromJson(userJson);
  // }
}