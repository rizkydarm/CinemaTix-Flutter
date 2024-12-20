part of '_bloc.dart';

class CityCubit extends Cubit<BlocState> {

  final CityUseCase cityUseCase;
  
  CityCubit(this.cityUseCase) : super(InitialState());

  Future<void> fetchCities() async {
    try {
      emit(LoadingState());
      final cities = await cityUseCase.getAllCities();
      emit(SuccessState(cities));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}