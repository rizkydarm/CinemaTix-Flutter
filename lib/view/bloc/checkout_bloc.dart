part of '_bloc.dart';

class CheckoutCubit extends Cubit<BlocState> {
  
  CheckoutCubit() : super(InitialState());

  MovieEntity? selectedMovie;
  SelectedCityCinemaMallEntity? selectedCinemaMall;
  SelectedDateTimeBookingEntity? selectedDateTimeBookingEntity;
  SelectedSeatsEntity? selectedSeatsEntity;

}