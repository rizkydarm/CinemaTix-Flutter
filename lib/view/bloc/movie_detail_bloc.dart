part of '_bloc.dart';

class MovieDetailCubit extends Cubit<BlocState<MovieDetailEntity>> {
  
  final MovieUseCase movieUseCase;

  MovieDetailCubit(this.movieUseCase) : super(const BlocState<MovieDetailEntity>.initial());

  Future<void> fetchMovieDetailById(String id) async {
    emit(const BlocState<MovieDetailEntity>.loading());
    try {
      final movie = await movieUseCase.getMovieDetailById(id);
      emit(BlocState<MovieDetailEntity>.success(movie));
    } catch (e) {
      emit(BlocState<MovieDetailEntity>.error(e.toString()));
    }
  }
}