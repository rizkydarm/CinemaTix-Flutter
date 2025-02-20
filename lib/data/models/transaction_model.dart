part of '../_data.dart';


class TransactionModel {
    final String id;
    final String userId;
    DateTime? datetime;
    DateTime? bookDatetime;
    String? status;
    String? seats;
    String? movie;
    String? place;
    String? totalPayment;
    String? paymentMethod;
    String? detail;
    String? noTransaction;

    TransactionModel({
       required this.id,
       required this.userId,
        this.datetime,
        this.bookDatetime,
        this.status,
        this.seats,
        this.movie,
        this.place,
        this.totalPayment,
        this.paymentMethod,
        this.detail,
        this.noTransaction,
    });

    factory TransactionModel.fromSQLJson(Map<String, dynamic> json) => TransactionModel(
        id: json["id"],
        userId: json["user_id"],
        datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        bookDatetime: json["book_datetime"] == null ? null : DateTime.parse(json["book_datetime"]),
        movie: json["movie"],
        status: json["status"],
        seats: json["seats"],
        place: json["place"],
        totalPayment: json["total_payment"],
        paymentMethod: json["payment_method"],
        detail: json["detail"],
        noTransaction: json["no_transaction"],
    );

    Map<String, dynamic> toSQLJson() => {
        "id": id,
        "user_id": userId,
        "datetime": datetime?.toIso8601String(),
        "book_datetime": bookDatetime?.toIso8601String(),
        "movie": movie,
        "status": status,
        "seats": seats,
        "place": place,
        "total_payment": totalPayment,
        "payment_method": paymentMethod,
        "detail": detail,
        "no_transaction": noTransaction,
    };
}
