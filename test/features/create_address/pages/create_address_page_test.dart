import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formularios_app/core/either/either.dart';
import 'package:formularios_app/features/create_address/domain/repositories/create_address_repository.dart';
import 'package:formularios_app/features/create_address/presentation/bloc/create_addres_bloc.dart';
import 'package:formularios_app/features/create_address/presentation/pages/create_addres_page.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';
import 'package:formularios_app/injection_container.dart' as di;
import 'package:formularios_app/shared/widgets/background.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../core/mock_go_router.dart';
import 'create_address_page_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<CreateAddressRepository>(), MockSpec<HomeRepository>()])
final createAddressRepository = MockCreateAddressRepository();
final homeRepository = MockHomeRepository();
void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await di.init();

    await di.sl.unregister<CreateAddressRepository>();
    di.sl.registerLazySingleton<CreateAddressRepository>(
        () => createAddressRepository);

    await di.sl.unregister<HomeRepository>();
    di.sl.registerLazySingleton<HomeRepository>(() => homeRepository);
  });
  testWidgets('create addresses page render ', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: CreateAddressPage()));

    expect(find.byType(BackGround), findsOneWidget);

    final createButton = find.byKey(const Key('create_address_button'));
    expect(createButton, findsOneWidget);

    await tester.ensureVisible(createButton);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    final closeButton = find.byKey(const Key('alert_close_button'));
    expect(closeButton, findsOneWidget);

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('addres_field')), '123123123');
    await tester.enterText(find.byKey(Key('city_field')), '123');
    await tester.enterText(find.byKey(Key('state_field')), '123');
    await tester.enterText(find.byKey(Key('zip_code_field')), '123123');
    await tester.pumpAndSettle();

    //errores por numeros campos ciudades y departamentos
    await tester.tap(createButton);
    await tester.pumpAndSettle();
    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('city_field')), 'city');
    await tester.enterText(find.byKey(Key('state_field')), 'department');
    await tester.pumpAndSettle();

    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.left('error'));

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    when(homeRepository.getEmailUSer())
        .thenAnswer((_) async => Either.right('email'));

    when(createAddressRepository.createAddress(
      address: anyNamed('address'),
      email: anyNamed('email'),
    )).thenAnswer((_) async => Either.left('error'));

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    when(createAddressRepository.createAddress(
      address: anyNamed('address'),
      email: anyNamed('email'),
    )).thenAnswer((_) async => Either.right(true));

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    await tester.tap(closeButton);
    await tester.pumpAndSettle();
  });
}

Widget makeTestableWidget(
    {required Widget child, Size size = const Size(450, 890)}) {
  final MockGoRouter goRouter = MockGoRouter();
  return MediaQuery(
      data: MediaQueryData(
        size: size,
      ),
      child: MaterialApp(
        home: MockGoRouterProvider(
          goRouter: goRouter,
          child: BlocProvider(
            create: (context) => CreateAddresBloc(
                createAddressRepository: createAddressRepository,
                homeRepository: homeRepository),
            child: child,
          ),
        ),
      ));
}
