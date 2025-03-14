import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/register/domain/repositories/register_repository.dart';
import 'package:formularios_app/features/register/presentation/bloc/register_bloc.dart';
import 'package:formularios_app/features/register/presentation/pages/register_page.dart';
import 'package:formularios_app/shared/widgets/background.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../core/mock_go_router.dart';
import 'registerpage_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RegisterRepository>()])
final registerRepository = MockRegisterRepository();
void main() {
  testWidgets('test for register page functions and response',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(
      child: RegisterPage(),
    ));

    expect(find.byType(BackGround), findsOneWidget);

    final registerButton = find.byKey(Key('register_button'));
    expect(registerButton, findsOneWidget);

    await tester.ensureVisible(registerButton);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    final close = find.byKey(Key('alert_close_button'));
    expect(close, findsOneWidget);

    await tester.tap(close);
    await tester.pumpAndSettle();

    when(registerRepository.createAcount(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => Either.left(''));

    await tester.enterText(find.byKey(Key('nameTextField')), '123123');
    await tester.enterText(find.byKey(Key('lastNameTextField')), '123123');
    await tester.enterText(find.byKey(Key('emailTextField')), '123123');
    await tester.enterText(find.byKey(Key('passwordTextField')), '123123');
    await tester.enterText(find.byKey(Key('birthdayTextField')), '123123');
    await tester.pumpAndSettle();

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    //error with the date
    await tester.tap(close);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('birthdayTextField')), '12-12-2021');
    await tester.pumpAndSettle();

    await tester.tap(registerButton);
    await tester.pumpAndSettle();
    //
    //error with the email
    await tester.tap(close);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(Key('emailTextField')), '123123@g.com');
    await tester.pumpAndSettle();

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    //error with the password

    await tester.tap(close);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(Key('passwordTextField')), 'Nikolas1@');
    await tester.pumpAndSettle();

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    //error service
    await tester.tap(close);
    await tester.pumpAndSettle();

    when(registerRepository.createAcount(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Either.right(true));

    when(registerRepository.registerUser(userData: anyNamed('userData')))
        .thenAnswer((_) async => Either.left('error con los datos'));

    await tester.tap(registerButton);

    await tester.pumpAndSettle();

    await tester.tap(close);
    await tester.pumpAndSettle();

    when(registerRepository.registerUser(userData: anyNamed('userData')))
        .thenAnswer((_) async => Either.right(true));

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    await tester.tap(close);
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
            create: (context) =>
                RegisterBloc(registerRepository: registerRepository),
            child: child,
          ),
        ),
      ));
}
