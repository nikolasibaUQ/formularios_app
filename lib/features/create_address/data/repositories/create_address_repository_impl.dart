import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/create_address/data/datasource/remote/create_address_firebase.dart';
import 'package:formularios_app/features/create_address/domain/repositories/create_address_repository.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';

class CreateAddressRepositoryImpl implements CreateAddressRepository {
  final CreateAddressFirebase firebaseApi;

  CreateAddressRepositoryImpl({required this.firebaseApi});

  @override
  Future<Either<String, bool>> createAddress(
      {required Address address, required String email}) {
    return firebaseApi.createAddress(address: address, email: email);
  }
}
