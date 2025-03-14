part of 'create_addres_bloc.dart';

@freezed
class CreateAddresEvent with _$CreateAddresEvent {
  const factory CreateAddresEvent.createAddres() = _CreateAddres;
  const factory CreateAddresEvent.clearAlert() = _ClearAlert;

  const factory CreateAddresEvent.changeAddress({required String address}) =
      _ChangeAddress;
  const factory CreateAddresEvent.changeCity({required String city}) =
      _ChangeCity;

  const factory CreateAddresEvent.changeDepartment(
      {required String department}) = _ChangeDepartment;

  const factory CreateAddresEvent.changeZipCode({required String zipCode}) =
      _ChangeZipCode;
}
