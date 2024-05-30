part of '_bloc.dart';

class MovieDetailCubit extends Cubit<BlocState> {
  
  final MovieUseCase movieUseCase;

  MovieDetailCubit(this.movieUseCase) : super(InitialState());

  Future<void> fetchMovieDetailById(String id) async {
    emit(LoadingState());
    try {
      final movie = await movieUseCase.getMovieDetailById(id);
      emit(SuccessState(movie));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}