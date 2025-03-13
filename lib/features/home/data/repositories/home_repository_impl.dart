import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/data/datasources/remote/home_firebase.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this.firebaseApi});

  final HomeFirebase firebaseApi;

  @override
  Future<Either<dynamic, List<Address>>> getAddreses({required String email}) {
    return firebaseApi.getAddreses(email: email);
  }

  @override
  Future<Either<String, String>> getEmailUSer() {
    return firebaseApi.getEmailUSer();
  }

  @override
  Future<Either> registerAddress({required Address address}) {
    return firebaseApi.registerAddress(address: address);
  }
}
