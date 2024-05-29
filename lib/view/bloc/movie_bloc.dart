part of '_bloc.dart';

class MovieCubit extends Cubit<BlocState<List<MovieEntity>>> {
  
  final MovieUseCase movieUseCase = MovieUseCase(MovieRepository(MovieRemoteDataSource(DioHelper(TMDBApi.baseUrl))));
  int currentPage = 1;
  
  bool isFetchingPaging = false;

  List<MovieEntity> _movies = [];

  MovieCubit() : super(const BlocState<List<MovieEntity>>.initial());

  Future<void> fetchNextPlayingNowMovies() async {
    if (isFetchingPaging) return;
    isFetchingPaging = true;

    emit(const BlocState<List<MovieEntity>>.loading());
    try {
      final movies = await movieUseCase.getPlayingNowMovies(page: currentPage);
      currentPage++;

      await Future.delayed(const Duration(seconds: 1));

      if (_movies.isNotEmpty) {
        print('add');
        _movies.addAll(movies);
        emit(BlocState<List<MovieEntity>>.success(_movies));
      } else {
        print('change');
        _movies = movies;
        emit(BlocState<List<MovieEntity>>.success(_movies));
      }

    } catch (e) {
      emit(BlocState<List<MovieEntity>>.error(e.toString()));
    } finally {
      isFetchingPaging = false;
    }
  }

  Future<void> fetchPlayingNowMovies() async {
    currentPage = 1;
    emit(const BlocState<List<MovieEntity>>.loading());
    try {
      final movies = await movieUseCase.getPlayingNowMovies();
      _movies = movies;
      emit(BlocState<List<MovieEntity>>.success(_movies));
    } catch (e) {
      emit(BlocState<List<MovieEntity>>.error(e.toString()));
    }
  }
}