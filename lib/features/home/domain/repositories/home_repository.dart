import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';

abstract class HomeRepository {
  Future<Either<String, String>> getEmailUSer();
  Future<Either<String, UserData>> getAddreses({required String email});
  Future<Either<String, bool>> deleteAddress(
      {required int index, required String email});
}
