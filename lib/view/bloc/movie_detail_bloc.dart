part of '_bloc.dart';

class MovieDetailCubit extends Cubit<BlocState> {
  
  final MovieUseCase _movieUseCase = getit.get<MovieUseCase>();

  MovieDetailEntity? movieDetailTemp;

  MovieDetailCubit() : super(InitialState());

  Future<void> fetchMovieDetailById(String id) async {
    emit(LoadingState());
    try {
      final movie = await _movieUseCase.getMovieDetailById(id);
      movieDetailTemp = movie;
      emit(SuccessState(movie));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'MovieDetailCubit.fetchMovieDetailById');
      emit(ErrorState(e.toString()));
    }
  }
}