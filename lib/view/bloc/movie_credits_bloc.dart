part of '_bloc.dart';

class MovieCreditsCubit extends Cubit<BlocState> {
  
  final MovieUseCase movieUseCase;

  MovieCreditsCubit(this.movieUseCase) : super(InitialState());

  Future<void> fetchMovieCreditsById(String id, {int max = 5}) async {
    emit(LoadingState());
    try {
      final credits = await movieUseCase.getMovieCreditsById(id);
      emit(SuccessState((credits.crews.sublist(max), credits.casts.sublist(max))));
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      emit(ErrorState(e.toString()));
    }
  }

  @override
  void onChange(Change<BlocState> change) {
    super.onChange(change);
  
    
  }
}