part of '_bloc.dart';

class WalletCubit extends Cubit<BlocState> {

  final TransactionUseCase _transactionUseCase = getit.get<TransactionUseCase>();
  
  WalletCubit(this.context) : super(InitialState());

  final BuildContext context;

  UserEntity? get _user => context.read<AuthCubit>().user;

  Future<void> fetchAllTransaction() async {
    try {
      if (_user == null) {
        emit(const ErrorState('User not found'));
        return;
      }
      emit(LoadingState());
      final trans = await _transactionUseCase.fetchAllByUser(_user!);
      emit(SuccessState(trans));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'CityCubit.fetchAllTransaction');
      emit(ErrorState(e.toString()));
    }
  }
}