
// import 'package:cinematix/core/_core.dart';
// import 'package:cinematix/data/_data.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'playingnow_movie_bloc.dart';
part 'upcoming_movie_bloc.dart';
part 'movie_detail_bloc.dart';


sealed class BlocState extends Equatable {
  const BlocState();

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return 'BlocState: $runtimeType';
  }
}

class InitialState extends BlocState {}

class LoadingState extends BlocState {}

class SuccessState<T> extends BlocState {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ErrorState extends BlocState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}