part of '_bloc.dart';

class SearchedMovieCubit extends Cubit<BlocState> {
  
  final MovieUseCase _movieUseCase = getit.get<MovieUseCase>();

  bool _isFetching = false;
  int currentPage = 1;

  SearchedMovieCubit() : super(InitialState());

  Future<void> fetchMovies(String query, {int page = 1, int? max, String? language}) async {
    if (_isFetching) return;
    _isFetching = true;
    
    emit(LoadingState());
    try {
      final movies = await _movieUseCase.getSearchedMovies(query, page: page);
      if (max != null) {
        currentPage = page;
        emit(SuccessState(movies.sublist(0, max)));
      } else {
        currentPage = page;
        emit(SuccessState(movies));
      }
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'SearchedMovieCubit.fetchMovies');
      emit(ErrorState(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}