import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/data/datasources/remote/home_firebase.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this.firebaseApi});

  final HomeFirebase firebaseApi;

  @override
  Future<Either<String, UserData>> getAddreses({required String email}) {
    return firebaseApi.getAddresses(email: email);
  }

  @override
  Future<Either<String, String>> getEmailUSer() {
    return firebaseApi.getEmailUSer();
  }

  @override
  Future<Either<String, bool>> deleteAddress(
      {required int index, required String email}) {
    return firebaseApi.deleteAddress(index: index, email: email);
  }
}
