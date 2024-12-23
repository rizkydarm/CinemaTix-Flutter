part of '_bloc.dart';

class MovieCreditsCubit extends Cubit<BlocState> {
  
  final MovieUseCase _movieUseCase = getit.get<MovieUseCase>();

  MovieCreditsCubit() : super(InitialState());

  Future<void> fetchMovieCreditsById(String id, {int max = 5}) async {
    emit(LoadingState());
    try {
      final credits = await _movieUseCase.getMovieCreditsById(id);
      emit(SuccessState((credits.crews.sublist(max), credits.casts.sublist(max))));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'MovieCreditsCubit.fetchMovieCreditsById');
      emit(ErrorState('MovieCreditsCubit.fetchMovieCreditsById Error: ${e.toString()}'));
    }
  }

  @override
  void onChange(Change<BlocState> change) {
    super.onChange(change);
  
    
  }
}