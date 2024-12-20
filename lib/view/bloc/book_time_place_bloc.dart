part of '_bloc.dart';

class BookTimePlaceCubit extends Cubit<BlocState> {

  BookTimePlaceCubit() : super(InitialState());

  final _places = <CinemaMallEntity>[
    CinemaMallEntity(
      mall: 'Paris van Java Mall',
      cinema: 'CGV',
      times: const [
        '12.00', '12.30', '13.00' , '13.30', '14.00', '14.30', '15.00'
      ]
    ),
    CinemaMallEntity(
      mall: 'Cihampelas Walk Mall',
      cinema: 'XXI',
      times: const [
        '12.00', '12.30', '13.00' , '13.30', '14.00', '14.30', '15.00'
      ]
    ),
    CinemaMallEntity(
      mall: 'Bandung Indah Plaza Mall',
      cinema: 'XXI',
      times: const [
        '12.00', '12.30', '13.00' , '13.30', '14.00', '14.30', '15.00'
      ]
    ),
    CinemaMallEntity(
      mall: 'Bandung Electronic Center Mall',
      cinema: 'CGV',
      times: const [
        '12.00', '12.30', '13.00' , '13.30', '14.00', '14.30', '15.00'
      ]
    ),
    CinemaMallEntity(
      mall: 'Pascal Shopping Center Mall',
      cinema: 'CGV',
      times: const [
        '12.00', '12.30', '13.00' , '13.30', '14.00', '14.30', '15.00'
      ]
    ),
    CinemaMallEntity(
      mall: 'Braga Mall',
      cinema: 'XXI',
      times: const [
        '12.00', '12.30', '13.00' , '13.30', '14.00', '14.30', '15.00'
      ]
    )
  ];


  List<String> createSevenDays() {
    final now = DateTime.now();
    final sevenDays = <String>[];
    for (int i = 0; i < 7; i++) {
      final temp = now.add(Duration(days: i+1));
      final formattedDate = DateFormat('EEE, d').format(temp);
      sevenDays.add(formattedDate);
    }
    return sevenDays;
  }

  Future<void> fetchAllCinemaMall() async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(SuccessState(_places));
  }

  @override
  void onChange(Change<BlocState> change) {
    super.onChange(change);
  
    
  }
}