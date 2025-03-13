part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default('') String email,
    @Default('') String password,
    LoginStateEnum? loginState,
  }) = _Initial;
}

enum LoginStateEnum {
  emptyPassword,
  emptyEmail,
  loading,
  success,
  error,
}
