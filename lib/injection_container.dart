import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:formularios_app/features/create_address/data/datasource/remote/create_address_firebase.dart';
import 'package:formularios_app/features/create_address/data/repositories/create_address_repository_impl.dart';
import 'package:formularios_app/features/create_address/domain/repositories/create_address_repository.dart';
import 'package:formularios_app/features/create_address/presentation/bloc/create_addres_bloc.dart';
import 'package:formularios_app/features/home/data/datasources/remote/home_firebase.dart';
import 'package:formularios_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';
import 'package:formularios_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:formularios_app/features/login/data/datasource/remote/login_firebase.dart';
import 'package:formularios_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:formularios_app/features/login/domain/repositories/login_repository.dart';
import 'package:formularios_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:formularios_app/features/register/data/datasource/remote/register_firebase.dart';
import 'package:formularios_app/features/register/data/repositories/register_repository_impl.dart';
import 'package:formularios_app/features/register/domain/repositories/register_repository.dart';
import 'package:formularios_app/features/register/presentation/bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //blocs
  sl.registerFactory(() => LoginBloc(loginRepository: sl()));
  sl.registerFactory(() => RegisterBloc(registerRepository: sl()));
  sl.registerFactory(() => HomeBloc(repository: sl()));
  sl.registerFactory(() =>
      CreateAddresBloc(createAddressRepository: sl(), homeRepository: sl()));

  //repositories
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(firebaseApi: sl()));

  sl.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(firebaseApi: sl()));

  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(firebaseApi: sl()));

  sl.registerLazySingleton<CreateAddressRepository>(
      () => CreateAddressRepositoryImpl(firebaseApi: sl()));

  //datasources
  sl.registerLazySingleton<LoginFirebase>(
      () => LoginFirebase(firebaseAuth: sl()));

  sl.registerLazySingleton<RegisterFirebase>(
      () => RegisterFirebase(firebaseAuth: sl(), firebaseDatabase: sl()));

  sl.registerLazySingleton<HomeFirebase>(
      () => HomeFirebase(firebaseAuth: sl(), firebaseDatabase: sl()));

  sl.registerLazySingleton<CreateAddressFirebase>(
      () => CreateAddressFirebase(firebaseDatabase: sl()));
  //dependencies
  sl.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
