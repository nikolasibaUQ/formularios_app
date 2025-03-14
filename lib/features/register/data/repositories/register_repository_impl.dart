import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/register/data/datasource/remote/register_firebase.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';
import 'package:formularios_app/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterFirebase firebaseApi;

  RegisterRepositoryImpl({required this.firebaseApi});

  @override
  Future<Either<String, bool>> registerUser({required UserData userData}) {
    return firebaseApi.registerUser(userData: userData);
  }

  @override
  Future<Either<String, bool>> createAcount(
      {required String email, required String password}) {
    return firebaseApi.createAcount(email: email, password: password);
  }
}
