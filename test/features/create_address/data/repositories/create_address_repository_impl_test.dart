import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/create_address/data/datasource/remote/create_address_firebase.dart';
import 'package:formularios_app/features/create_address/data/repositories/create_address_repository_impl.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_address_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseDatabase>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
  MockSpec<DatabaseReference>(),
  MockSpec<DataSnapshot>(),
  MockSpec<DatabaseEvent>(),
])
final firebaseDatabaseMock = MockFirebaseDatabase();
final api = CreateAddressFirebase(firebaseDatabase: firebaseDatabaseMock);
final datasource = CreateAddressRepositoryImpl(firebaseApi: api);
final userCredentialMock = MockUserCredential();
final mockUser = MockUser();
final DatabaseReference databaseReferenceMock = MockDatabaseReference();
final DataSnapshot dataSnapshotMock = MockDataSnapshot();
final DatabaseEvent databaseEventMock = MockDatabaseEvent();

void main() {
  test('should return true when user is  null', () async {
    // Arrange
    when(firebaseDatabaseMock.ref()).thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('users'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.orderByChild('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.equalTo('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.once())
        .thenAnswer((_) async => databaseEventMock);
    when(databaseEventMock.snapshot).thenReturn(dataSnapshotMock);
    when(dataSnapshotMock.exists).thenReturn(false);

    final response =
        await datasource.createAddress(email: 'email', address: addres);

    expect(response, Either<String, bool>.left('Usuario no encontrado.'));
  });

  test('should return true when user is exception', () async {
    // Arrange
    when(firebaseDatabaseMock.ref()).thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('users'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.orderByChild('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.equalTo('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.once())
        .thenAnswer((_) async => databaseEventMock);
    when(databaseEventMock.snapshot).thenThrow(Exception('Error'));

    final response =
        await datasource.createAddress(email: 'email', address: addres);

    expect(
        response,
        Either<String, bool>.left(
            "Error al agregar dirección: Exception: Error"));
  });

  test('should return true when user is exception', () async {
    // Arrange
    when(firebaseDatabaseMock.ref()).thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('users'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.orderByChild('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.equalTo('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.once())
        .thenAnswer((_) async => databaseEventMock);
    when(databaseEventMock.snapshot).thenThrow(Exception('Error'));

    // Add stubs for the child method with the argument 'users/key'
    when(databaseReferenceMock.child('users/key'))
        .thenReturn(databaseReferenceMock);

    final response =
        await datasource.createAddress(email: 'email', address: addres);

    expect(
        response,
        Either<String, bool>.left(
            "Error al agregar dirección: Exception: Error"));
  });

  test('when all is ok', () async {
    when(firebaseDatabaseMock.ref()).thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('users'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.orderByChild('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.equalTo('email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.once())
        .thenAnswer((_) async => databaseEventMock);
    when(databaseEventMock.snapshot).thenReturn(dataSnapshotMock);
    when(dataSnapshotMock.exists).thenReturn(true);
    when(dataSnapshotMock.value).thenReturn({
      'user_email': {
        'email': 'email',
        'name': 'name',
        'lastName': 'lastName',
        'birthDate': 'birthDate',
        'password': 'password',
        'addresses': [
          {
            'address': '123 Main St',
            'city': 'Anytown',
            'state': 'CA',
            'zipCode': '12345',
          }
        ],
      }
    });

    // Add stubs for the child method with the argument 'user_email'
    when(databaseReferenceMock.child('users/user_email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('users/user_email/addresses'))
        .thenReturn(databaseReferenceMock);

    // Act
    final response =
        await datasource.createAddress(address: addres, email: 'email');

    // Assert
    expect(response, Either<String, bool>.right(true));
  });
}

final addres = Address(
    address: 'address', city: 'city', state: 'state', zipCode: 'zipCode');
