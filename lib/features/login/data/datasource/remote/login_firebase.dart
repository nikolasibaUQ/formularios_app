import 'package:firebase_auth/firebase_auth.dart';
import 'package:formularios_app/core/either/either.dart';

class LoginFirebase {
  final FirebaseAuth firebaseAuth;

  LoginFirebase({required this.firebaseAuth});

  Future<Either<String, bool>> login(String email, String password) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return response.user != null ? Either.right(true) : Either.left('Error');
    } catch (e) {
      return Either.left(e.toString());
    }
  }
}
