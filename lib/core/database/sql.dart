part of '../_core.dart';

class SQLHelper {

  SQLHelper._();
  
  static final SQLHelper sql = SQLHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      return _database = await _initDB();
    }
  }

  Future<Database> _initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "cinematix.db");
    return await openDatabase(path);
  }
}