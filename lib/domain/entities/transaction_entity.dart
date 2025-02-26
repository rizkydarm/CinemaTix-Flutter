part of '../_domain.dart';

class TransactionEntity extends Entity {

  final String id;
  final String userId;
  final DateTime datetime;
  final String noTransaction;
  final DateTime bookDatetime;
  final MovieEntity movie;
  final String status;
  final List<String> seats;
  final CityEntity city;
  final CinemaMallEntity cinemaMall;
  final String totalPayment;
  final String paymentMethod;
  final Map<String, String> detail;
  
  TransactionEntity({
    required this.id,
    required this.userId,
    required this.noTransaction,
    required this.movie,
    required this.city,
    required this.status,
    required this.seats,
    required this.datetime,
    required this.bookDatetime,
    required this.cinemaMall,
    required this.totalPayment,
    required this.paymentMethod,
    required this.detail,
  });

  @override
  List<Object?> get props => [id, movie, datetime];

  Map<String, Object> toSQLJson() => {
    "id": id,
    "user_id": userId,
    "datetime": datetime.toIso8601String(),
    "no_transaction": noTransaction,
    "book_datetime": bookDatetime.toIso8601String(),
    "movie": movie.toString(),
    "status": status,
    "seats": seats.join(','),
    "cinema_mall": cinemaMall.toString(),
    "total_payment": totalPayment,
    "payment_method": paymentMethod,
    "detail": detail,
  };
}