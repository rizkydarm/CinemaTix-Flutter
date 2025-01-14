part of '../_domain.dart';

class TransactionEntity extends Entity {

  final String id;
  final String userId;
  final DateTime datetime;
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
}