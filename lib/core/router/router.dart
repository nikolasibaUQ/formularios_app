import 'package:flutter/material.dart';
import 'package:formularios_app/features/create_address/presentation/pages/create_addres_page.dart';
import 'package:formularios_app/features/home/presentation/pages/home_page.dart';
import 'package:formularios_app/features/login/presentation/pages/login_page.dart';
import 'package:formularios_app/features/register/presentation/pages/register_page.dart';
import 'package:formularios_app/main.dart';
import 'package:go_router/go_router.dart';

mixin RouterMixin on State<MyApp> {
  late final GoRouter router;

  @override
  void initState() {
    super.initState();

    router = GoRouter(routes: [
      GoRoute(
        name: LoginPage.routeName,
        path: LoginPage.routePath,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
          path: RegisterPage.routePath,
          name: RegisterPage.routeName,
          builder: (context, state) => RegisterPage()),
      GoRoute(
          path: HomePage.routePath,
          name: HomePage.routeName,
          builder: (context, state) => HomePage()),
      GoRoute(
          path: CreateAddressPage.routePath,
          name: CreateAddressPage.routeName,
          builder: (context, state) => CreateAddressPage()),
    ]);
  }
}
