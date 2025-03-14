import 'package:formularios_app/core/either/either.dart';

abstract class LoginRepository {
  Future<Either<String, bool>> login({
    required String email,
    required String password,
  });
}
