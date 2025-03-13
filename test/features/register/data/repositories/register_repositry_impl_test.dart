import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/register/data/datasource/remote/register_firebase.dart';
import 'package:formularios_app/features/register/data/repositories/register_repository_impl.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repositry_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<FirebaseDatabase>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
  MockSpec<DatabaseReference>(),
])

/// 🔹 Instancias de los mocks
final firebaseMock = MockFirebaseAuth();
final firebaseDatabaseMock = MockFirebaseDatabase();
final api = RegisterFirebase(
    firebaseAuth: firebaseMock, firebaseDatabase: firebaseDatabaseMock);
final datasource = RegisterRepositoryImpl(firebaseApi: api);
final userCredentialMock = MockUserCredential();
final mockUser = MockUser(); //
final DatabaseReference databaseReferenceMock = MockDatabaseReference();

void main() {
  group('Login Tests', () {
    setUp(() {
      ///
      when(userCredentialMock.user).thenReturn(null);

      when(firebaseDatabaseMock.ref()).thenReturn(databaseReferenceMock);
    });

    test('should return false when user is null', () async {
      // Arrange (Preparamos el escenario de fallo)
      when(firebaseMock.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => userCredentialMock);

      // Act
      final result =
          await datasource.createAcount(email: '123', password: '123');

      // Assert
      expect(result, Either<String, bool>.left('Error al crear la cuenta')); //
    });

    test('should return true when user is not null', () async {
      // Arrange
      when(firebaseMock.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => userCredentialMock);

      // 🔹 Aquí configuramos un usuario válido
      when(userCredentialMock.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('valid_uid');

      // Act
      final result =
          await datasource.createAcount(email: '123', password: '123');

      // Assert
      expect(result, Either<String, bool>.right(true));
    });

    test('should return true when user is a throw ', () async {
      // Arrange
      when(firebaseMock.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(
        code: 'code',
        message: 'message',
      ));

      when(userCredentialMock.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('valid_uid');

      // Act
      final result =
          await datasource.createAcount(email: '123', password: '123');

      // Assert
      expect(result, Either<String, bool>.left('message'));
    });

    test('create user in database', () async {
      // Arrange
      final userData = UserData(
        name: 'name',
        lastName: 'lastName',
        birthDate: '123123',
      );

      when(firebaseDatabaseMock.ref('users')).thenReturn(databaseReferenceMock);

      when(databaseReferenceMock.child('user_name'))
          .thenReturn(databaseReferenceMock);

      when(databaseReferenceMock.set(any)).thenAnswer((_) async {});

      final result = await datasource.registerUser(userData: userData);

      // Assert
      expect(result, Either<String, bool>.right(true));
    });

    test('create user in database and get error', () async {
      // Arrange
      final userData = UserData(
        name: 'name',
        lastName: 'lastName',
        birthDate: '123123',
      );

      when(firebaseDatabaseMock.ref('users')).thenReturn(databaseReferenceMock);

      when(databaseReferenceMock.child('user_name'))
          .thenReturn(databaseReferenceMock);

      when(databaseReferenceMock.set(any)).thenThrow(FirebaseAuthException(
        code: 'code',
        message: 'message',
      ));

      final result = await datasource.registerUser(userData: userData);

      // Assert
      expect(result, Either<String, bool>.left('message'));
    });

    test('datauser model test coverage', () {
      final data = UserData(
        name: 'name',
        lastName: 'lastName',
        birthDate: '123123',
      );

      final json = data.toJson();

      expect(json, isA<Map<String, dynamic>>());

      final data2 = UserData.fromJson(json);

      expect(data2, isA<UserData>());
    });
  });
}
