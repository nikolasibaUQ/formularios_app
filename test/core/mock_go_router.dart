import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {
  final Object? returnObject;

  MockGoRouter({this.returnObject});
  @override
  Future<T?> pushReplacementNamed<T extends Object?>(
    String path, {
    Object? extra,
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
  }) {
    return Future.delayed(Duration.zero, () {
      return returnObject as T?;
    });
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String path, {
    Object? extra,
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
  }) {
    return Future.delayed(Duration.zero, () {
      return returnObject as T?;
    });
  }

  @override
  void goNamed(String name,
      {String? fragment,
      Map<String, String> pathParameters = const <String, String>{},
      Map<String, dynamic> queryParameters = const <String, dynamic>{},
      Object? extra}) {
    return;
  }

  @override
  GoRouteInformationProvider get routeInformationProvider =>
      GoRouteInformationProvider(initialExtra: null, initialLocation: '/');
}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    super.key,
  });

  /// The mock navigator used to mock navigation calls.
  final MockGoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: goRouter,
        child: child,
      );
}
