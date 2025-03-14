import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/login/data/datasource/remote/login_firebase.dart';
import 'package:formularios_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

///
@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
])

/// 🔹 Instancias de los mocks
final firebaseMock = MockFirebaseAuth();
final api = LoginFirebase(firebaseAuth: firebaseMock);
final datasource = LoginRepositoryImpl(firebaseApi: api);
final userCredentialMock = MockUserCredential();
final mockUser = MockUser(); //

void main() {
  group('Login Tests', () {
    setUp(() {
      ///
      when(userCredentialMock.user).thenReturn(null);
    });

    test('should return false when user is null', () async {
      // Arrange (Preparamos el escenario de fallo)
      when(firebaseMock.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => userCredentialMock);

      // Act
      final result = await datasource.login(email: '123', password: '123');

      // Assert
      expect(result, Either<String, bool>.left('Error')); //
    });

    test('result when we have a exception ', () async {
      // Arrange
      when(firebaseMock.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(Exception('Error'));

      // Act
      final result = await datasource.login(email: '123', password: '123');

      // Assert
      expect(result, Either<String, bool>.left('Exception: Error'));
    });

    test('should return true when user is not null', () async {
      // Arrange
      when(firebaseMock.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => userCredentialMock);

      // 🔹 Aquí configuramos un usuario válido
      when(userCredentialMock.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('valid_uid');

      // Act
      final result = await datasource.login(email: '123', password: '123');

      // Assert
      expect(result, Either<String, bool>.right(true));
    });
  });
}
