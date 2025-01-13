part of '../_domain.dart';

class TransactionEntity extends Entity {

  final String id;
  final DateTime datetime;
  final MovieEntity movie;
  final CityEntity city;
  final CinemaMallEntity cinemaMall;
  final String totalPayment;
  final String paymentMethod;
  final Map<String, String> detail;
  
  TransactionEntity({
    required this.movie,
    required this.city,
    required this.cinemaMall,
    required this.totalPayment,
    required this.paymentMethod,
    required this.detail,
  }) : datetime = DateTime.now(), id = const Uuid().v4();

  @override
  List<Object?> get props => [id, movie, datetime]; 
}