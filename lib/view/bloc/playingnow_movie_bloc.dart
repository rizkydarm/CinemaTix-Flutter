part of '_bloc.dart';

class PlayingNowMovieCubit extends MovieCubit {
  
  final MovieUseCase movieUseCase;

  bool _isFetching = false;

  PlayingNowMovieCubit(this.movieUseCase) : super(InitialState());

  @override
  Future<void> fetchMovies({int page = 1, int? max, String? language}) async {
    if (_isFetching) return;
    _isFetching = true;
    
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final movies = await movieUseCase.getPlayingNowMovies(page: page);
      if (max != null) {
        currentPage = page;
        emit(SuccessState(movies.sublist(0, max)));
      } else {
        currentPage = page;
        emit(SuccessState(movies));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}