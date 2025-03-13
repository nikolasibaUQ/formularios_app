import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.repository}) : super(_Initial()) {
    on<_Started>(_started);
    on<_RegisterAddress>(_registerAddress);
  }

  final HomeRepository repository;

  Future<void> _started(_Started event, Emitter<HomeState> emit) async {
    final email = await repository.getEmailUSer();

    await email.when(
        left: (_) {},
        right: (value) async {
          final addresses = await repository.getAddreses(email: value);

          addresses.when(
              left: (_) {},
              right: (value) {
                emit(state.copyWith(addresses: value));
              });
        });
  }

  Future<void> _registerAddress(
      _RegisterAddress event, Emitter<HomeState> emit) async {}
}
