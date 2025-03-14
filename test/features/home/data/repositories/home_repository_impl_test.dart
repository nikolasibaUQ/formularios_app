import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/data/datasources/remote/home_firebase.dart';
import 'package:formularios_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<FirebaseDatabase>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
  MockSpec<DatabaseReference>(),
  MockSpec<DataSnapshot>(),
  MockSpec<DatabaseEvent>(),
])
final firebaseMock = MockFirebaseAuth();
final firebaseDatabaseMock = MockFirebaseDatabase();
final api = HomeFirebase(
    firebaseAuth: firebaseMock, firebaseDatabase: firebaseDatabaseMock);
final datasource = HomeRepositoryImpl(firebaseApi: api);
final userCredentialMock = MockUserCredential();
final mockUser = MockUser(); //
final DatabaseReference databaseReferenceMock = MockDatabaseReference();
final DataSnapshot dataSnapshotMock = MockDataSnapshot();
final DatabaseEvent databaseEventMock = MockDatabaseEvent();

void main() {
  test('should return true when user is not null', () async {
    // Arrange
    when(firebaseMock.currentUser).thenReturn(mockUser);
    when(mockUser.email).thenReturn('email@email.com');

    final response = await datasource.getEmailUSer();

    expect(response, Either<String, String>.right('email@email.com'));
  });

  test('should return false when user is null', () async {
    // Arrange
    when(firebaseMock.currentUser).thenReturn(null);

    final response = await datasource.getEmailUSer();

    expect(response, Either<String, String>.left('Error'));
  });

  test('should return true when user is throws an exception', () async {
    // Arrange
    when(firebaseMock.currentUser).thenThrow(Exception('Error'));

    final response = await datasource.getEmailUSer();

    expect(
        response, Either<String, String>.left(Exception('Error').toString()));
  });

  //getAddresses

  test('should return true when user is not null', () async {
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

    final response = await datasource.getAddreses(email: 'email');

    expect(
        response,
        Either<String, UserData>.left(
            'No se encontraron datos para este usuario.'));
  });

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
    when(dataSnapshotMock.value).thenReturn(null);

    final response = await datasource.getAddreses(email: 'email');

    expect(
        response,
        Either<String, UserData>.left(
            'No se encontraron datos para este usuario.'));
  });

  test('should return true when user is not format', () async {
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
    when(dataSnapshotMock.value).thenReturn('data');

    final response = await datasource.getAddreses(email: 'email');

    expect(
        response,
        Either<String, UserData>.left(
            'Formato de datos inesperado en Firebase.'));
  });

  test('should return true when throw ', () async {
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
    when(dataSnapshotMock.value).thenThrow(Exception('Error'));

    final response = await datasource.getAddreses(email: 'email');

    expect(
        response,
        Either<String, UserData>.left(
            'Error al obtener los datos: Exception: Error'));
  });

  test('should return true when all is succes ', () async {
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

    final response = await datasource.getAddreses(email: 'email');

    expect(response, Either<String, UserData>.right(userData));
  });

  test('delete address with null data', () async {
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
    when(dataSnapshotMock.value).thenReturn(null);

    final response = await datasource.deleteAddress(index: 0, email: 'email');

    expect(
        response,
        Either<String, bool>.left(
            'No se encontraron datos para este usuario.'));
  });

  test('delete address with null data', () async {
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
    when(dataSnapshotMock.value).thenThrow('data');

    final response = await datasource.deleteAddress(index: 0, email: 'email');

    expect(response,
        Either<String, bool>.left('Error al eliminar la dirección: data'));
  });

  test('delete address with succes data', () async {
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
    when(databaseReferenceMock.child('user_email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('addresses'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('users'))
        .thenReturn(databaseReferenceMock);

    // Act
    final response = await datasource.deleteAddress(index: 0, email: 'email');

    // Assert
    expect(response, Either<String, bool>.right(true));
  });

  test('delete address with index  error', () async {
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
    when(databaseReferenceMock.child('user_email'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('addresses'))
        .thenReturn(databaseReferenceMock);
    when(databaseReferenceMock.child('users'))
        .thenReturn(databaseReferenceMock);

    // Act
    final response = await datasource.deleteAddress(index: 2, email: 'email');

    // Assert
    expect(response, Either<String, bool>.left('Índice inválido.'));
  });

  test('test for entitie', () {
    final address = Address(
      address: '123 Main St',
      city: 'Anytown',
      state: 'CA',
      zipCode: '12345',
    );

    final json = {
      'address': '123 Main St',
      'city': 'Anytown',
      'state': 'CA',
      'zipCode': '12345',
    };

    expect(address.toJson(), json);
  });
}

UserData userData = UserData(
  email: 'email',
  name: 'name',
  lastName: 'lastName',
  birthDate: 'birthDate',
  password: 'password',
  addresses: [
    Address(
      address: '123 Main St',
      city: 'Anytown',
      state: 'CA',
      zipCode: '12345',
    )
  ],
);
