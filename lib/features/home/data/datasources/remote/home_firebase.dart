import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';

class HomeFirebase {
  HomeFirebase({required this.firebaseAuth, required this.firebaseDatabase});

  final FirebaseAuth firebaseAuth;
  final FirebaseDatabase firebaseDatabase;

  Future<Either<String, String>> getEmailUSer() async {
    try {
      final response = firebaseAuth.currentUser;
      return response?.email != null
          ? Either.right(response!.email!)
          : Either.left('Error');
    } catch (e) {
      return Either.left(e.toString());
    }
  }

  Future<Either<dynamic, List<Address>>> getAddreses(
      {required String email}) async {
    try {
      final response = await firebaseDatabase
          .ref()
          .child("users")
          .orderByChild('email')
          .equalTo(email)
          .once();

      if (response.snapshot.value == null) {
        return Either.left("No se encontraron direcciones para este usuario.");
      }

      // Convertir a Map<String, dynamic> de manera segura
      final data = Map<String, dynamic>.from(response.snapshot.value as Map);

      // Extraer el primer valor del mapa (datos del usuario)
      final userData = Map<String, dynamic>.from(data.values.first);

      // Obtener la lista de direcciones si existe, sino devolver lista vacía
      final addresses = (userData['addresses'] as List?) ?? [];

      return Either.right(addresses
          .map((e) => Address.fromJson(Map<String, dynamic>.from(e)))
          .toList());
    } catch (e) {
      return Either.left(e.toString());
    }
  }

  Future<Either<dynamic, dynamic>> registerAddress(
      {required Address address}) async {
    return throw UnimplementedError();
  }
}
