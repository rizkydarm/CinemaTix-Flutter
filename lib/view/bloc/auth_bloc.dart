part of '_bloc.dart';

class AuthCubit extends Cubit<BlocState> {

  final AuthUseCase _authUseCase =  getit.get<AuthUseCase>();
  
  AuthCubit() : super(InitialState());

  UserEntity? _user;

  UserEntity? get user => _user;

  Future<void> register(String email, String password) async {
    try {
      emit(LoadingState());
      _user = await _authUseCase.register(email, password);
      await Future.delayed(const Duration(seconds: 2));
      emit(SuccessState(_user));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'AuthCubit.register');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(LoadingState());
      _user = await _authUseCase.login(email, password);
      await Future.delayed(const Duration(seconds: 2));
      emit(SuccessState(_user));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'AuthCubit.login');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(LoadingState());
      await _authUseCase.logout();
      await Future.delayed(const Duration(seconds: 2));
      emit(const SuccessState(null));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'AuthCubit.logout');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> getUser() async {
    try {
      emit(LoadingState());
      _user = await _authUseCase.getUser();
      await Future.delayed(const Duration(seconds: 2));
      emit(SuccessState(_user));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'AuthCubit.getUser');
      emit(ErrorState(e.toString()));
    }
  }
}