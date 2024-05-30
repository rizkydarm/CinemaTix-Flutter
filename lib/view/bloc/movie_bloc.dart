part of '_bloc.dart';

class MovieCubit extends Cubit<BlocState> {
  
  final MovieUseCase movieUseCase;

  int currentPage = 1;
  static const int pageSize = 20;

  bool _isFetching = false;

  MovieCubit(this.movieUseCase) : super(InitialState());

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