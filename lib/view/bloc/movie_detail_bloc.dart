part of '_bloc.dart';

class MovieDetailCubit extends Cubit<BlocState> {
  
  final MovieUseCase _movieUseCase;

  MovieDetailEntity? movieDetailTemp;

  MovieDetailCubit(this._movieUseCase) : super(InitialState());

  Future<void> fetchMovieDetailById(String id) async {
    emit(LoadingState());
    try {
      final movie = await _movieUseCase.getMovieDetailById(id);
      movieDetailTemp = movie;
      emit(SuccessState(movie));
    } catch (e, s) {
      talker.handle(e, s, 'MovieDetailCubit.fetchMovieDetailById');
      emit(ErrorState('MovieDetailCubit.fetchMovieDetailById Error: ${e.toString()}'));
    }
  }
}