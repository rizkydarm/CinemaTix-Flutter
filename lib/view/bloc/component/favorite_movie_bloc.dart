part of '../_bloc.dart';

class FavoriteMovieCubit extends Cubit<BlocState> {

  final FavoriteMovieUseCase _usecase = getit.get<FavoriteMovieUseCase>();

  FavoriteMovieCubit(this.context) : super(InitialState());

  final BuildContext context;

  UserEntity? get _user => context.read<AuthCubit>().user;

  List<FavoriteMovieEntity> _favoriteMovies = [];

  Future<void> init() async {
    if (_user == null) {
      emit(const ErrorState('User not found'));
      return;
    }
    emit(LoadingState());
    _favoriteMovies = await _usecase.getAllFavoriteMovies(_user!.id);
    emit(SuccessState(_favoriteMovies));
  }

  Future<void> toggle(String movieId) async {

    if (_user == null) {
      emit(const ErrorState('User not found'));
      return;
    }

    emit(LoadingState());

    try {
      if (_favoriteMovies.any((data) => data.movieId == movieId)) {
        await _usecase.removeFavoriteMovie(_user!.id, movieId);
        _favoriteMovies = await _usecase.getAllFavoriteMovies(_user!.id);
        emit(SuccessState(_favoriteMovies));
      } else {
        await _usecase.addFavoriteMovie(_user!.id, movieId);
        _favoriteMovies = await _usecase.getAllFavoriteMovies(_user!.id);
        emit(SuccessState(_favoriteMovies));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}