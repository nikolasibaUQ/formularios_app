part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.nameChanged(String name) = _NameChanged;
  const factory RegisterEvent.lastNameChanged(String lastName) =
      _LastNameChanged;
  const factory RegisterEvent.changeBirthDate(String birthDate) =
      _ChangeBirthDate;
  const factory RegisterEvent.emailChanged(String email) = _EmailChanged;
  const factory RegisterEvent.passwordChanged(String password) =
      _PasswordChanged;

  const factory RegisterEvent.register() = _Register;
  const factory RegisterEvent.deleteAlert() = _DeleteAlert;
}
