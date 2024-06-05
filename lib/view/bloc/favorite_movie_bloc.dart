part of '_bloc.dart';

class FavoriteMovieCubit extends Cubit<BlocState> {
  
  final MovieUseCase movieUseCase;

  FavoriteMovieCubit(this.movieUseCase) : super(InitialState());

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