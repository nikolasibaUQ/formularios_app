import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/create_address/domain/repositories/create_address_repository.dart';
import 'package:formularios_app/features/home/domain/entiites/address.dart';
import 'package:formularios_app/features/home/domain/repositories/home_repository.dart';
import 'package:formularios_app/shared/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_addres_bloc.freezed.dart';
part 'create_addres_event.dart';
part 'create_addres_state.dart';

class CreateAddresBloc extends Bloc<CreateAddresEvent, CreateAddresState> {
  CreateAddresBloc(
      {required this.createAddressRepository, required this.homeRepository})
      : super(_Initial()) {
    on<_CreateAddres>(_onCreateAddres);

    on<_ClearAlert>((event, emit) {
      emit(state.copyWith(status: null, message: null));
    });
    on<_ChangeAddress>((event, emit) {
      emit(state.copyWith(address: event.address));
    });
    on<_ChangeCity>((event, emit) {
      emit(state.copyWith(city: event.city));
    });
    on<_ChangeDepartment>((event, emit) {
      emit(state.copyWith(department: event.department));
    });
    on<_ChangeZipCode>((event, emit) {
      emit(state.copyWith(postalCode: event.zipCode));
    });
  }

  final CreateAddressRepository createAddressRepository;
  final HomeRepository homeRepository;

  Future<void> _onCreateAddres(
    _CreateAddres event,
    Emitter<CreateAddresState> emit,
  ) async {
    if (state.address.isEmpty ||
        state.city.isEmpty ||
        state.department.isEmpty ||
        state.postalCode.isEmpty) {
      emit(state.copyWith(status: CreateAddresEventEnum.emptyFields));
      return;
    } else if (!Utils.validateNoNumbers(state.city) ||
        !Utils.validateNoNumbers(state.department)) {
      emit(state.copyWith(
          status: CreateAddresEventEnum.error,
          message: 'La ciudad y el departamento no pueden contener números'));
      return;
    }

    emit(state.copyWith(status: CreateAddresEventEnum.loading));

    final email = await homeRepository.getEmailUSer();

    await email.when(left: (left) {
      emit(state.copyWith(status: CreateAddresEventEnum.error));
    }, right: (value) async {
      final result = await createAddressRepository.createAddress(
        email: value,
        address: Address(
            address: state.address,
            city: state.city,
            state: state.department,
            zipCode: state.postalCode),
      );

      result.when(left: (_) {
        emit(state.copyWith(status: CreateAddresEventEnum.error));
      }, right: (_) {
        emit(state.copyWith(status: CreateAddresEventEnum.success));
      });
    });
  }
}
