part of '../_bloc.dart';

class FavoriteMovieCubit extends Cubit<BlocState> {

  FavoriteMovieCubit() : super(InitialState());

  final _movieIds = <String>[];

  void toggle(String movieId) async {
    if (_movieIds.contains(movieId)) {
      _movieIds.removeWhere((element) => element == movieId);
      emit(const SuccessState(''));
    } else {
      _movieIds.add(movieId);
      emit(SuccessState(movieId));
    }
  }
}