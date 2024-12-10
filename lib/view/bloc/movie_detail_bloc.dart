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
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}