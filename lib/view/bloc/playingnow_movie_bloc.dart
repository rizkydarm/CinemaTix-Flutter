part of '_bloc.dart';

class PlayingNowMovieCubit extends Cubit<BlocState> {
  
  final MovieUseCase movieUseCase;

  int currentPage = 1; 

  bool _isFetching = false;

  PlayingNowMovieCubit(this.movieUseCase) : super(InitialState());

  Future<void> fetchPlayingNowMovies({int page = 1, String? language}) async {
    if (_isFetching) return;
    _isFetching = true;
    
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final movies = await movieUseCase.getPlayingNowMovies(page: page);
      currentPage = page;
      emit(SuccessState(movies));
    } catch (e) {
      emit(ErrorState(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}