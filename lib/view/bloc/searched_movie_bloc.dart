part of '_bloc.dart';

class SearchedMovieCubit extends Cubit<BlocState> {
  
  final MovieUseCase movieUseCase;

  bool _isFetching = false;
  int currentPage = 1;

  SearchedMovieCubit(this.movieUseCase) : super(InitialState());

  Future<void> fetchMovies(String query, {int page = 1, int? max, String? language}) async {
    if (_isFetching) return;
    _isFetching = true;
    
    emit(LoadingState());
    try {
      final movies = await movieUseCase.getSearchedMovies(query, page: page);
      if (max != null) {
        currentPage = page;
        emit(SuccessState(movies.sublist(0, max)));
      } else {
        currentPage = page;
        emit(SuccessState(movies));
      }
    } catch (e, s) {
      talker.handle(e, s, 'SearchedMovie.fetchMovies');
      emit(ErrorState('SearchedMovie.fetchMovies Error: ${e.toString()}'));
    } finally {
      _isFetching = false;
    }
  }
}