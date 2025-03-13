import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';
import 'package:formularios_app/features/register/domain/repositories/register_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.registerRepository}) : super(_Initial()) {
    on<_Register>(_onRegister);
    on<_NameChanged>(_onNameChanged);
    on<_LastNameChanged>(_onLastNameChanged);
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_ChangeBirthDate>(_onChangeBirthDate);
    on<_DeleteAlert>((event, emit) {
      emit(state.copyWith(registerAlert: null));
    });
  }

  final RegisterRepository registerRepository;

  Future<void> _onRegister(_Register event, Emitter<RegisterState> emit) async {
    if (state.name.isEmpty ||
        state.lastName.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.birthDate.isEmpty) {
      emit(state.copyWith(registerAlert: RegisterAlerts.emptyFields));
      return;
    }

    // Call the register service

    emit(state.copyWith(registerAlert: RegisterAlerts.loading));
    final response = await registerRepository.createAcount(
        email: state.email, password: state.password);

    await response.when(left: (error) async {
      emit(state.copyWith(registerAlert: RegisterAlerts.error, message: error));
    }, right: (_) async {
      final userData = UserData(
        name: state.name,
        lastName: state.lastName,
        birthDate: state.birthDate,
      );

      final response =
          await registerRepository.registerUser(userData: userData);

      response.when(
        left: (error) {
          emit(state.copyWith(
              registerAlert: RegisterAlerts.error, message: error));
        },
        right: (_) {
          emit(state.copyWith(registerAlert: RegisterAlerts.success));
        },
      );
    });
  }

  void _onNameChanged(_NameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onLastNameChanged(_LastNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onEmailChanged(_EmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(_PasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onChangeBirthDate(_ChangeBirthDate event, Emitter<RegisterState> emit) {
    emit(state.copyWith(birthDate: event.birthDate));
  }
}
