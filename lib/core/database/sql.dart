part of '../_core.dart';

class SQLHelper {

  Database? _database;

  Future<SQLHelper> init() async {
    try {
      final dataBasePath = await getDatabasesPath();
      final path = join(dataBasePath, "cinematix.db");
      _database = await openDatabase(path,
        onOpen: (db) async {
          db.execute("PRAGMA foreign_keys = ON");
          final tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
          final tablesName = tables.map((e) => e['name']).toList();
          print('Tables: $tablesName');
        }
      );
      // await clearDatabase();
      return this;
    } catch (e) {      
      throw Exception('Failed to open database');
    }
  }

  Future<void> createTable(String table, List<SQLColumn> columns) async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    final columnsDefinition = <String>[];
    for (var column in columns) {
      final type = column.type;
      final columnDefinition = '${column.name} $type${column.isPrimaryKey ? ' PRIMARY KEY' : ''}${column.canBeNull ? '' : ' NULL'}';
      columnsDefinition.add(columnDefinition);
    }

    final sql = 'CREATE TABLE $table (${columnsDefinition.join(', ')})';
    await _database!.execute(sql);
  }

  Future<bool> isTableExists(String table) async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    try {
      final result = await _database!.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        [table]
      );
      return result.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check if table exists');
    }
  }

  Future<void> close() async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    try {
      await _database!.close();
    } catch (e) {
      throw Exception('Failed to close database');
    }
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    await _database!.insert(table, data);
    // try {
    // } catch (e) {
    //   throw Exception('Failed to insert data');
    // }
  }

  Future<void> update(String table, Map<String, dynamic> data, String where, List<dynamic> whereArgs) async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    await _database!.update(table, data, where: where, whereArgs: whereArgs);
    // try {
    //   // _printAllData(table);
    // } catch (e) {
    //   throw Exception('Failed to update data in database');
    // }
  }

  Future<void> delete(String table, String where, List<dynamic> whereArgs) async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    await _database!.delete(table, where: where, whereArgs: whereArgs);
    // try {
    // } catch (e) {
    //   throw Exception('Failed to delete data in database');
    // }
  }

  Future<List<Map<String, dynamic>>> query(String table, {String? where, List<dynamic>? whereArgs}) async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    try {
      final result = await _database?.query(table, where: where, whereArgs: whereArgs);
      // _printAllData(table);
      if (result != null) {
        return result;
      } else {
        throw Exception('Failed to query data in database');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _printAllData(String table) async {
    try {
      final data = await _database!.query(table);
      for (var row in data) {
        print(row);
      }
    } catch (e) {
      throw Exception('Failed to print all data from database');
    }
  }

  Future<void> clearDatabase() async {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    try {
      final tables = await _database!.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
      for (var table in tables) {
        final tableName = table['name'];
        if (tableName != null && tableName != 'sqlite_sequence') {
          await _database!.execute('DROP TABLE IF EXISTS $tableName');
        }
      }
    } catch (e) {
      throw Exception('Failed to clear database');
    }
  }

}

class SQLType {
  static const text = 'TEXT';
  static const integer = 'INTEGER';
  static const real = 'REAL';
  static const blob = 'BLOB';
}

class SQLColumn {
  final String name;
  final String type;
  final bool isPrimaryKey;
  final bool canBeNull;

  SQLColumn(this.name, this.type, {this.isPrimaryKey = false, this.canBeNull = false});
}