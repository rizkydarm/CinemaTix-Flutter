part of '../_data.dart';

class TransactionRepository implements Repository {
  
  final TransactionDataSource _localDataSource = getit.get<TransactionDataSource>();

  Future<List<TransactionEntity>> fetchAllByUser(UserEntity user) async {
    final result = await _localDataSource.fetchAllByUser(user.id);
    return result.map((e) {
      
      final movieDecode = jsonDecode(e.movie!) as Map;
      final placeDecode = jsonDecode(e.place!) as Map;
      final cityDecode = jsonDecode(placeDecode['city']) as Map;

      return TransactionEntity(
        id: e.id,
        userId: e.userId,
        datetime: e.datetime!,
        bookDatetime: e.bookDatetime!,
        movie: MovieEntity(
          id: movieDecode['id'],
          title: movieDecode['title'],
          posterPath: movieDecode['poster_path'],
          genres: movieDecode["genres"] == null ? [] : List<String>.from(movieDecode["genres"]!.map((x) => x)),
          overview: movieDecode["overview"]
        ),
        city: CityEntity(id: cityDecode['id'], name: cityDecode['name']),
        cinemaMall: CinemaMallEntity(mall: placeDecode['mall'], cinema: placeDecode['cinema']),
        status: e.status!,
        seats: e.seats!.split(',').toList(),
        paymentMethod: e.paymentMethod!,
        totalPayment: e.totalPayment!,
        detail: Map<String, String>.from(jsonDecode(e.detail!))
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