import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';

class RegisterFirebase {
  final FirebaseAuth firebaseAuth;
  final FirebaseDatabase firebaseDatabase;

  RegisterFirebase({
    required this.firebaseAuth,
    required this.firebaseDatabase,
  });

  Future<Either<String, bool>> registerUser(
      {required UserData userData}) async {
    try {
      final db = firebaseDatabase.ref('users').child('user_${userData.name}');
      await db.set(userData.toJson());

      return Either.right(true);
    } on FirebaseAuthException catch (e) {
      return Either.left(e.message ?? 'Error al ejecutar el servicio');
    }
  }

  Future<Either<String, bool>> createAcount(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response.user != null
          ? Either.right(true)
          : Either.left('Error al crear la cuenta');
    } on FirebaseAuthException catch (e) {
      return Either.left(e.message ?? 'Error al ejecutar el servicio');
    }
  }
}
