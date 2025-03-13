import 'package:firebase_auth/firebase_auth.dart';

class LoginFirebase {
  final FirebaseAuth firebaseAuth;

  LoginFirebase({required this.firebaseAuth});

  Future<bool> login(String email, String password) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return response.user != null;
    } catch (e) {
      return false;
    }
  }
}
