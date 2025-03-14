part of 'create_addres_bloc.dart';

@freezed
class CreateAddresState with _$CreateAddresState {
  const factory CreateAddresState.initial({
    @Default('') String address,
    @Default('') String city,
    @Default('') String postalCode,
    @Default('') String department,
    CreateAddresEventEnum? status,
  }) = _Initial;
}

enum CreateAddresEventEnum {
  emptyFields,
  loading,
  success,
  error,
}
