import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:formularios_app/features/login/presentation/pages/login_page.dart';
import 'package:formularios_app/features/register/presentation/bloc/register_bloc.dart';
import 'package:formularios_app/firebase_options.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => di.sl<LoginBloc>()),
      BlocProvider(create: (context) => di.sl<RegisterBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formularios App',
      home: LoginPage(),
    );
  }
}
