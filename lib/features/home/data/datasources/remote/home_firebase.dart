import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';

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

  Future<Either<String, UserData>> getAddresses({required String email}) async {
    try {
      final response = await firebaseDatabase
          .ref()
          .child("users")
          .orderByChild('email')
          .equalTo(email)
          .once();

      if (response.snapshot.value == null) {
        return Either.left("No se encontraron datos para este usuario.");
      }

      if (response.snapshot.value != null && response.snapshot.value is! Map) {
        return Either.left("Formato de datos inesperado en Firebase.");
      }

      final Map<String, dynamic> userDataRaw =
          (response.snapshot.value as Map).values.first.cast<String, dynamic>();

      final List<dynamic> rawAddresses = userDataRaw.remove('addresses') ?? [];

      final userData = UserData.fromJson(userDataRaw);

      final List<Address> addresses = rawAddresses
          .map((e) => Address.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      return Either.right(userData.copyWith(addresses: addresses));
    } catch (e) {
      return Either.left("Error al obtener los datos: ${e.toString()}");
    }
  }

  Future<Either<String, bool>> deleteAddress({
    required int index,
    required String email,
  }) async {
    try {
      final response = await firebaseDatabase
          .ref()
          .child("users")
          .orderByChild('email')
          .equalTo(email)
          .once();

      if (response.snapshot.value == null) {
        return Either.left("No se encontraron datos para este usuario.");
      }

      final Map<String, dynamic> usersMap =
          (response.snapshot.value as Map).cast<String, dynamic>();

      // Extraer la clave del usuario (Firebase genera claves aleatorias por usuario)
      final String userKey = usersMap.keys.first;
      final Map<String, dynamic> userData =
          usersMap[userKey].cast<String, dynamic>();

      // Extraer lista de direcciones
      final List<dynamic> addresses = List.from(userData['addresses'] ?? []);

      if (index < 0 || index >= addresses.length) {
        return Either.left("Índice inválido.");
      }

      // Eliminar la dirección en la posición especificada
      addresses.removeAt(index);

      // Actualizar Firebase con la nueva lista de direcciones
      await firebaseDatabase.ref().child("users").child(userKey).update({
        'addresses': addresses,
      });

      return Either.right(true);
    } catch (e) {
      return Either.left("Error al eliminar la dirección: ${e.toString()}");
    }
  }
}
