part of '../_data.dart';

class FavoriteMovieLocalDataSource implements LocalDataSource {

  final SQLHelper _sql = getit.get<SQLHelper>();

  FavoriteMovieLocalDataSource() {
    // getit.get<SQLHelper>().then((value) {
    //   _sql = value;
    // });

    if (_sql == null) {
      throw Exception('SQLHelper is not initialized');
    }
    _sql!.isTableExists('favorite_movie').then((isUserTableExist) {
      if (!isUserTableExist) {
        _createTable();
      }
    });
  }

  Future<void> _createTable() async {
    await _sql!.createTable('favorite_movie', [
      SQLColumn('id', SQLType.text, isPrimaryKey: true),
      SQLColumn('user_id', SQLType.text),
      SQLColumn('movie_id', SQLType.text),
    ]);
  }

  Future<void> insertFavoriteMovie(String userId, String movieId) async {
    if (_sql == null) {
      throw Exception('SQLHelper is not initialized');
    }
    await _sql!.insert('favorite_movie', {
      'id': const Uuid().v4(),
      'user_id': userId,
      'movie_id': movieId,
    });
  }

  Future<void> removeFavoriteMovie(String userId, String movieId) async {
    if (_sql == null) {
      throw Exception('SQLHelper is not initialized');
    }
    await _sql!.delete(
      'favorite_movie',
      where: 'user_id = ? AND movie_id = ?',
      whereArgs: [userId, movieId],
    );
  }

  Future<void> clearFavoriteMovies() async {
    if (_sql == null) {
      throw Exception('SQLHelper is not initialized');
    }
    await _sql!.delete('favorite_movie', where: '1 = 1');
  }
  
  Future<List<FavoriteMovieModel>> getUserFavoriteMovies(String userId) async {
    if (_sql == null) {
      throw Exception('SQLHelper is not initialized');
    }
    final result = await _sql!.query(
      'favorite_movie',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return result.map((data) => FavoriteMovieModel.fromSQLJson(data)).toList();
  }

}