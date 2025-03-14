import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';
import 'package:formularios_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:formularios_app/features/home/presentation/pages/home_page.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';
import 'package:formularios_app/shared/widgets/background.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../core/mock_go_router.dart';
import 'home_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeRepository>()])
final homeRepository = MockHomeRepository();
void main() {
  testWidgets('render a normal home page with empty addresses',
      (WidgetTester tester) async {
    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.right('nikolas@example.com'));
    when(homeRepository.getAddreses(email: anyNamed('email')))
        .thenAnswer((_) async => Either.right(userEmptyData));

    await tester.pumpWidget(makeTestableWidget(child: HomePage()));

    expect(find.byType(BackGround), findsOneWidget);
  });

  testWidgets(
      'render home page with data an delete error an succes and start is succes ',
      (
    WidgetTester tester,
  ) async {
    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.right('nikolasiba@example.com'));
    when(homeRepository.getAddreses(email: anyNamed('email')))
        .thenAnswer((_) async => Either.right(userData));

    ////

    await tester.pumpWidget(makeTestableWidget(child: HomePage()));
    await tester.pumpAndSettle();

    ///
    final deleteButton = find.byKey(const Key('delete_button')).first;
    expect(deleteButton, findsOneWidget);

    when(homeRepository.deleteAddress(
      email: anyNamed('email'),
      index: anyNamed('index'),
    )).thenAnswer((_) async => Either.left('Error'));

    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    final close = find.byKey(const Key('alert_close_button'));
    expect(close, findsOneWidget);

    await tester.tap(close);
    await tester.pumpAndSettle();

    //
    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.left('nikolasiba@example.com'));

    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    expect(close, findsOneWidget);

    //

    await tester.tap(close);
    await tester.pumpAndSettle();

    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.right('nikolasiba@example.com'));

    when(homeRepository.deleteAddress(
      email: anyNamed('email'),
      index: anyNamed('index'),
    )).thenAnswer((_) async => Either.right(true));

    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    await tester.tap(close);
    expect(close, findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('add_address_button')), findsOneWidget);

    await tester.tap(find.byKey(const Key('add_address_button')));
    await tester.pumpAndSettle();
  });

  testWidgets('render home page with error get address',
      (WidgetTester tester) async {
    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.left(''));
    await tester.pumpWidget(makeTestableWidget(child: HomePage()));
    await tester.pumpAndSettle();

    final close = find.byKey(const Key('alert_close_button'));

    expect(close, findsOneWidget);

    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.right('nikolas'));
    when(homeRepository.getAddreses(email: anyNamed('email')))
        .thenAnswer((_) async => Either.left('Error'));

    await tester.tap(close);
    await tester.pumpAndSettle();

    expect(close, findsOneWidget);

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
            create: (context) => HomeBloc(repository: homeRepository),
            child: child,
          ),
        ),
      ));
}

const userEmptyData = UserData(
  name: 'Nikolas',
  lastName: 'Melgarejo',
  email: 'nikolasiba@example.com',
  password: '123123',
  birthDate: '1999-12-12',
  addresses: [],
);

final userData = UserData(
  name: 'Nikolas',
  lastName: 'Melgarejo',
  email: 'nikolasiba@example.com',
  password: '123123',
  birthDate: '1999-12-12',
  addresses: [
    Address(
      address: 'Calle 1',
      city: 'Cochabamba',
      state: 'Cochabamba',
      zipCode: '123123',
    ),
    Address(
      address: 'Calle 2',
      city: 'Cochabamba',
      state: 'Cochabamba',
      zipCode: '123123',
    ),
  ],
);
