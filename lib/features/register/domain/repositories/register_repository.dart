import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';

abstract class RegisterRepository {
  Future<Either<String, bool>> registerUser({
    required UserData userData,
  });

  Future<Either<String, bool>> createAcount({
    required String email,
    required String password,
  });
}
