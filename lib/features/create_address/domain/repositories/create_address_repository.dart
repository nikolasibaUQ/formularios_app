import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';

abstract class CreateAddressRepository {
  Future<Either<String, bool>> createAddress(
      {required Address address, required String email});
}
