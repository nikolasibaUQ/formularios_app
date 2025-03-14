import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/login/domain/repositories/login_repository.dart';
import 'package:formularios_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:formularios_app/features/login/presentation/pages/login_page.dart';
import 'package:formularios_app/injection_container.dart' as di;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../core/mock_go_router.dart';
import 'login_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginRepository>()])
//
final loginRepository = MockLoginRepository();
void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });
  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: LoginPage()));

    expect(find.text('Bienvenido'), findsOneWidget);

    final loginBtn = find.byKey(const Key('loginBtn'));

    expect(loginBtn, findsOneWidget);

    await tester.tap(loginBtn);
    await tester.pumpAndSettle();

    final closeBtn = find.byKey(const Key('alert_close_button'));

    expect(closeBtn, findsOneWidget);

    await tester.tap(closeBtn);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(Key('registerBtn')));

    await tester.tap(find.byKey(Key('registerBtn')));
    await tester.pumpAndSettle();

    final emailField = find.byKey(const Key('emailTextField'));
    final passwordField = find.byKey(const Key('passwordTextField'));

    await tester.enterText(emailField, '123123');
    await tester.pumpAndSettle();

    await tester.tap(loginBtn);
    await tester.pumpAndSettle();

    await tester.tap(closeBtn);
    await tester.pumpAndSettle();

    await tester.enterText(passwordField, '123123');
    await tester.pumpAndSettle();

    when(loginRepository.login(email: '123123', password: '123123'))
        .thenAnswer((_) async => Either.left('Error'));

    await tester.tap(loginBtn);
    await tester.pumpAndSettle();

    await tester.tap(closeBtn);
    await tester.pumpAndSettle();

    when(loginRepository.login(email: '123123', password: '123123'))
        .thenAnswer((_) async => Either.right(true));

    await tester.tap(loginBtn);
    await tester.pumpAndSettle(Durations.medium1);

    await tester.tap(closeBtn);
    await tester.pumpAndSettle();

    final registerBtn = find.byKey(const Key('registerBtn'));
    await tester.ensureVisible(registerBtn);

    await tester.tap(registerBtn);
    await tester.pumpAndSettle();
  });
}

Widget makeTestableWidget(
    {required Widget child, Size size = const Size(400, 800)}) {
  final MockGoRouter goRouter = MockGoRouter();

  return MediaQuery(
      data: MediaQueryData(
        size: size,
      ),
      child: MaterialApp(
        home: MockGoRouterProvider(
          goRouter: goRouter,
          child: BlocProvider(
            create: (context) => LoginBloc(loginRepository: loginRepository),
            child: child,
          ),
        ),
      ));
}
