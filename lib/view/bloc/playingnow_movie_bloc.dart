part of '_bloc.dart';

class PlayingNowMovieCubit extends MovieCubit {
  
  final MovieUseCase _movieUseCase = getit.get<MovieUseCase>();

  bool _isFetching = false;

  PlayingNowMovieCubit() : super(InitialState());

  @override
  Future<void> fetchMovies({int page = 1, int? max, String? language}) async {
    if (_isFetching) return;
    _isFetching = true;
    
    emit(LoadingState());
    try {
      final movies = await _movieUseCase.getPlayingNowMovies(page: page);
      if (max != null) {
        currentPage = page;
        emit(SuccessState(movies.sublist(0, max)));
      } else {
        currentPage = page;
        emit(SuccessState(movies));
      }
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'PlayingNow.fetchMovies');
      emit(ErrorState('PlayingNow.fetchMovies Error: ${e.toString()}'));
    } finally {
      _isFetching = false;
    }
  }
}