
import 'package:cinematix/core/_core.dart';
import 'package:cinematix/data/_data.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_bloc.dart';
part 'movie_detail_bloc.dart';


enum BlocStatus { initial, loading, success, error }

class BlocState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const BlocState._({required this.status, this.data, this.errorMessage});

  const BlocState.initial() : this._(status: BlocStatus.initial);
  const BlocState.loading() : this._(status: BlocStatus.loading);
  const BlocState.success(T data) : this._(status: BlocStatus.success, data: data);
  const BlocState.error(String message) : this._(status: BlocStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [
    status,
    data,
    errorMessage,
  ];

  @override
  String toString() {
    return 'BlocState { status: $status, data: ${data.runtimeType}, errorMessage: $errorMessage }';
  }
}