part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial({
    @Default('') String name,
    @Default('') String lastName,
    @Default('') String birthDate,
    @Default('') String email,
    @Default('') String password,
    RegisterAlerts? registerAlert,
    @Default('') String? message,
  }) = _Initial;
}

enum RegisterAlerts { success, error, emptyFields, loading }
