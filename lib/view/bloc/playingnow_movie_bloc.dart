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
      final movies = await movieUseCase.getPlayingNowMovies(page: page);
      if (max != null) {
        currentPage = page;
        emit(SuccessState(movies.sublist(0, max)));
      } else {
        currentPage = page;
        emit(SuccessState(movies));
      }
    } catch (e, s) {
      talker.handle(e, s, 'PlayingNow.fetchMovies');
      emit(ErrorState('PlayingNow.fetchMovies Error: ${e.toString()}'));
    } finally {
      _isFetching = false;
    }
  }
}