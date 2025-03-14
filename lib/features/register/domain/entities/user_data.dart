import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
abstract class UserData with _$UserData {
  const factory UserData({
    required String name,
    required String lastName,
    required String birthDate,
    required String email,
    required String password,
    List<Address>? addresses,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
