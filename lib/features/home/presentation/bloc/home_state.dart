part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default([]) List<Address> addresses,
  }) = _Initial;
}
