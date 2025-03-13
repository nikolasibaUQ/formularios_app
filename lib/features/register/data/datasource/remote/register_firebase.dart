import 'package:firebase_auth/firebase_auth.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';

class RegisterFirebase {
  final FirebaseAuth firebaseAuth;

  RegisterFirebase({required this.firebaseAuth});

  Future<dynamic> registerUser({required UserData userData}) async {
    return throw UnimplementedError();
  }

  Future createAcount({required String email, required String password}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
