part of '_bloc.dart';

class UpComingMovieCubit extends Cubit<BlocState> {
  
  final MovieUseCase movieUseCase;

  int currentPage = 1; 

  bool _isFetching = false;

  UpComingMovieCubit(this.movieUseCase) : super(InitialState());

  Future<void> fetchMovies({int page = 1, int? max, String? language}) async {
    if (_isFetching) return;
    _isFetching = true;
    
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final movies = await movieUseCase.getUpComingMovies(page: page);
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