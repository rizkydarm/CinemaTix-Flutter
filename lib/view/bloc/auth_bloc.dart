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
      emit(SuccessState(_user));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'AuthUseCase.register');
      emit(ErrorState('AuthUseCase.login register: ${e.toString()}'));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(LoadingState());
      final cities = await _authUseCase.login(email, password);
      emit(SuccessState(cities));
    } catch (e, s) {
      getit.get<Talker>().handle(e, s, 'AuthUseCase.login');
      emit(ErrorState('AuthUseCase.login Error: ${e.toString()}'));
    }
  }
}