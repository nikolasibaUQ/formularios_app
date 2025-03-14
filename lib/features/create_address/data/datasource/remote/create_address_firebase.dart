import 'package:firebase_database/firebase_database.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';

class CreateAddressFirebase {
  CreateAddressFirebase({required this.firebaseDatabase});

  final FirebaseDatabase firebaseDatabase;

  Future<Either<String, bool>> createAddress(
      {required Address address, required String email}) async {
    try {
      final response = await firebaseDatabase
          .ref()
          .child("users")
          .orderByChild('email')
          .equalTo(email)
          .once();

      if (response.snapshot.value == null) {
        return Either.left("Usuario no encontrado.");
      }

      final rawData = response.snapshot.value as Map;
      final String userKey =
          rawData.keys.first; // Obtiene la llave única del usuario
      final Map<String, dynamic> userData =
          Map<String, dynamic>.from(rawData[userKey]);

      // 🔹 Obtener lista actual de direcciones como lista mutable
      List<dynamic> currentAddresses =
          List<dynamic>.from(userData['addresses'] ?? []);

      // 🔹 Agregar la nueva dirección
      currentAddresses.add(address.toJson());

      // 🔹 Actualizar Firebase con la nueva lista de direcciones
      await firebaseDatabase.ref().child("users/$userKey").update({
        "addresses": currentAddresses,
      });

      return Either.right(true);
    } catch (e) {
      return Either.left("Error al agregar dirección: ${e.toString()}");
    }
  }
}
