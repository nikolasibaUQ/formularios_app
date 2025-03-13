import 'package:formularios_app/features/register/domain/entities/user_data.dart';

abstract class RegisterRepository {
  Future<dynamic> registerUser({
    required UserData userData,
  });

  Future<dynamic> createAcount({
    required String email,
    required String password,
  });
}
