import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/login/data/datasource/remote/login_firebase.dart';
import 'package:formularios_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.firebaseApi});

  final LoginFirebase firebaseApi;

  @override
  Future<Either<String, bool>> login(
      {required String email, required String password}) {
    return firebaseApi.login(email, password);
  }
}
