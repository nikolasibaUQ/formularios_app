import 'package:firebase_auth/firebase_auth.dart';
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

  //repositories
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(firebaseApi: sl()));

  sl.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(firebaseApi: sl()));

  //datasources
  sl.registerLazySingleton<LoginFirebase>(
      () => LoginFirebase(firebaseAuth: sl()));

  sl.registerLazySingleton<RegisterFirebase>(
      () => RegisterFirebase(firebaseAuth: sl()));

  //dependencies

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
