part of '_bloc.dart';

class CheckoutCubit extends Cubit<BlocState> {
  
  CheckoutCubit() : super(InitialState());

  MovieEntity? selectedMovie;
  SelectedCityCinemaMallEntity? selectedCinemaMall;
  SelectedDateTimeBookingEntity? selectedDateTimeBookingEntity;
  SelectedSeatsEntity? selectedSeatsEntity;
  
  final TransactionUseCase _transactionUseCase = getit.get<TransactionUseCase>();

  Future<TransactionEntity?> saveTransaction(UserEntity user, String totalPayment, String paymentMethod, Map<String, String> detail) async {
    try {
      emit(LoadingState());
      final seats = selectedSeatsEntity!.positions.map((e) {
        final abc = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
        return '${e.$1}${abc[e.$2]}';
      }).toList();
      final en = TransactionEntity(
        id: const Uuid().v4(),
        noTransaction: '#${generateRandomNumberString(16)}',
        datetime: DateTime.now(),
        movie: selectedMovie!, 
        userId: user.id,
        city: selectedCinemaMall!.city, 
        bookDatetime: DateTime(DateTime.now().year, DateTime.now().month, 
          int.parse(selectedDateTimeBookingEntity!.date.split('').last),
          int.parse(selectedDateTimeBookingEntity!.time.split('.').first),
          int.parse(selectedDateTimeBookingEntity!.time.split('.').last)
        ),
        seats: seats,
        status: 'waiting', 
        cinemaMall: selectedCinemaMall!.cinemaMall, 
        totalPayment: totalPayment, 
        paymentMethod: paymentMethod, 
        detail: detail
      );
      await _transactionUseCase.add(en);
      getit.get<FirebaseAnalytics>().logAddPaymentInfo(
        currency: 'IDR',
        value: (int.tryParse(totalPayment) ?? 0).toDouble(),
        parameters: en.toSQLJson(),
      );
      emit(const SuccessState(null));
      return en;
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'CheckoutCubit.saveTransaction');
      emit(ErrorState(e.toString()));
    }
    return null;
  }
}