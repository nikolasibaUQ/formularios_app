import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';
import 'package:formularios_app/features/register/domain/entities/user_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.repository}) : super(_Initial()) {
    on<_Started>(_started);

    on<_DeleteAddress>(_deleteAddress);
    on<_DeleteAlert>((event, emit) {
      emit(state.copyWith(alert: null));
    });
  }

  final HomeRepository repository;

  Future<void> _started(_Started event, Emitter<HomeState> emit) async {
    final email = await repository.getEmailUSer();

    await email.when(left: (_) {
      emit(state.copyWith(alert: HomeStateAlerts.errorGetAddress));
    }, right: (value) async {
      final addresses = await repository.getAddreses(email: value);

      addresses.when(left: (_) {
        emit(state.copyWith(alert: HomeStateAlerts.errorGetAddress));
      }, right: (value) {
        emit(state.copyWith(userData: value));
      });
    });
  }

  Future<void> _deleteAddress(
      _DeleteAddress event, Emitter<HomeState> emit) async {
    final email = await repository.getEmailUSer();

    await email.when(left: (_) {
      emit(state.copyWith(alert: HomeStateAlerts.error));
    }, right: (value) async {
      final delete =
          await repository.deleteAddress(email: value, index: event.index);

      delete.when(left: (_) {
        emit(state.copyWith(alert: HomeStateAlerts.error));
      }, right: (value) {
        final updatedAddresses = List.of(state.userData!.addresses!)
          ..removeAt(event.index);
        emit(state.copyWith(
            alert: HomeStateAlerts.deleteAddress,
            userData: state.userData!.copyWith(
              addresses: updatedAddresses,
            )));
      });
    });
  }
}
