
// import 'package:cinematix/core/_core.dart';
// import 'package:cinematix/data/_data.dart';
import 'package:cinematix/core/_core.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

part 'searched_movie_bloc.dart';
part 'playingnow_movie_bloc.dart';
part 'upcoming_movie_bloc.dart';
part 'component/favorite_movie_bloc.dart';
part 'movie_detail_bloc.dart';
part 'movie_credits_bloc.dart';
part 'book_time_place_bloc.dart';
part 'city_bloc.dart';
part 'auth_bloc.dart';
part 'checkout_bloc.dart';


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

abstract class MovieCubit extends Cubit<BlocState> {
  MovieCubit(super.initialState);
  int currentPage = 1;
  List<MovieEntity>? movies;
  Future<void> fetchMovies({int page = 1, int? max, String? language});
}

// class MyBlocObserver extends BlocObserver {
//   @override
//   void onCreate(BlocBase bloc) {
//     super.onCreate(bloc);
//     print('onCreate -- ${bloc.runtimeType}');
//   }

//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('onChange -- ${bloc.runtimeType}, $change');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     print('onError -- ${bloc.runtimeType}, $error');
//     super.onError(bloc, error, stackTrace);
//   }

//   @override
//   void onClose(BlocBase bloc) {
//     super.onClose(bloc);
//     print('onClose -- ${bloc.runtimeType}');
//   }
// }