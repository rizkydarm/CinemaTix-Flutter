part of '_bloc.dart';

class CityCubit extends Cubit<BlocState> {

  final CityUseCase _cityUseCase = getit.get<CityUseCase>();
  
  CityCubit() : super(InitialState());

  Future<void> fetchCities() async {
    try {
      emit(LoadingState());
      final cities = await _cityUseCase.getAllCities();
      emit(SuccessState(cities));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'CityCubit.fetchCities');
      emit(ErrorState(e.toString()));
    }
  }
}