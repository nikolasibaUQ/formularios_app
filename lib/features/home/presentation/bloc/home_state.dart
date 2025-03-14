part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(null) UserData? userData,
    HomeStateAlerts? alert,
  }) = _Initial;
}

enum HomeStateAlerts {
  deleteAddress,
  error,
  errorGetAddress,
}
