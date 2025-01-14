part of '../_data.dart';

class TransactionRepository implements Repository {
  
  final TransactionDataSource _localDataSource = getit.get<TransactionDataSource>();

  Future<List<TransactionEntity>> fetchAll() async {
    final result = await _localDataSource.fetchAll();
    return result.map((e) {
      return TransactionEntity(
        id: e.id,
        userId: e.userId,
        movie: 
      );
    }).toList();
  }

  Future<void> add(TransactionEntity entity) async {
    final movie = jsonEncode({
      'id': entity.movie.id,
      'title': entity.movie.title,
      'poster_path': entity.movie.posterPath,
      'genres': entity.movie.genres,
      'overview': entity.movie.overview,
    });
    final place = jsonEncode({
      'city': jsonEncode({'id': entity.city.id, 'name': entity.city.name}),
      'mall': entity.cinemaMall.mall,
      'cinema': entity.cinemaMall.cinema,
    });
    final model = TransactionModel(
      id: entity.id,
      userId: entity.userId,
      datetime: entity.datetime,
      bookDatetime: entity.bookDatetime,
      movie: movie,
      seats: entity.seats.join(','),
      status: entity.status,
      place: place,
      paymentMethod: entity.paymentMethod,
      totalPayment: entity.totalPayment,
      detail: jsonEncode(entity.detail)
    );
    await _localDataSource.add(model);
  }
}