import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/login/domain/repositories/login_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginRepository}) : super(_Initial()) {
    on<_Login>(_login);
    on<_EmailChanged>(_emailChanged);
    on<_PasswordChanged>(_passwordChanged);

    on<_DeleteState>((event, emit) {
      emit(state.copyWith(loginState: null));
    });
  }

  final LoginRepository loginRepository;

  void _emailChanged(_EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(_PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _login(_Login event, Emitter<LoginState> emit) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(
        loginState: state.email.isEmpty
            ? LoginStateEnum.emptyEmail
            : LoginStateEnum.emptyPassword,
      ));
      return;
    }

    emit(state.copyWith(loginState: LoginStateEnum.loading));
    final response = await loginRepository.login(
      email: state.email,
      password: state.password,
    );

    response.when(left: (left) {
      emit(state.copyWith(loginState: LoginStateEnum.error));
    }, right: (right) {
      emit(state.copyWith(loginState: LoginStateEnum.success));
    });
  }
}
