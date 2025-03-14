import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/create_address/presentation/bloc/create_addres_bloc.dart';
import 'package:formularios_app/features/home/presentation/pages/home_page.dart';
import 'package:formularios_app/injection_container.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/path_images.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';
import 'package:formularios_app/shared/widgets/background.dart';
import 'package:formularios_app/shared/widgets/custom_dialog.dart';
import 'package:formularios_app/shared/widgets/custom_primary_button.dart';
import 'package:formularios_app/shared/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';

class CreateAddressPage extends StatelessWidget {
  const CreateAddressPage({super.key});

  static String routeName = '/create-address';
  static String routePath = '/create-address';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return BlocProvider(
      create: (context) => sl<CreateAddresBloc>(),
      child: BlocListener<CreateAddresBloc, CreateAddresState>(
        listener: (context, state) {
          if (state.status == CreateAddresEventEnum.success) {
            CustomDialog(
                onClose: () => context.goNamed(HomePage.routeName),
                context: context,
                title: 'Dirección registrada',
                subtitle: 'La dirección ha sido registrada correctamente',
                icon: Image.asset(Paths.images.success));
          } else if (state.status == CreateAddresEventEnum.error) {
            CustomDialog(
                onClose: () => context
                    .read<CreateAddresBloc>()
                    .add(CreateAddresEvent.clearAlert()),
                context: context,
                title: 'Error',
                subtitle: 'Ha ocurrido un error al registrar la dirección',
                icon: Image.asset(Paths.images.error));
          } else if (state.status == CreateAddresEventEnum.emptyFields) {
            CustomDialog(
                onClose: () => context
                    .read<CreateAddresBloc>()
                    .add(CreateAddresEvent.clearAlert()),
                context: context,
                title: 'Uno de los campos esta vacío',
                subtitle: 'Por favor, llena todos los campos',
                icon: Image.asset(Paths.images.error));
          }
        },
        child: BlocBuilder<CreateAddresBloc, CreateAddresState>(
          builder: (context, state) {
            return BackGround(
              child: Positioned(
                left: responsive.wp(2.5),
                top: responsive.hp(28),
                height: responsive.hp(60),
                width: responsive.wp(95),
                child: SizedBox(
                  width: responsive.wp(85),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: MyColors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Registra una nueva dirección',
                            textAlign: TextAlign.center,
                            style: TextStyles.dynamicTextStyle(
                                isBold: true,
                                lineSpacing: 1.5,
                                fontFamily: Fonts.mPLUSRounded1cMedium,
                                fontSize: responsive.fp(22),
                                color: MyColors.violetBlue),
                          ),
                          SizedBox(height: responsive.hp(6)),
                          CustomTextField(
                            key: Key('addres_field'),
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: MyColors.violetBlue,
                              size: responsive.dp(2.5),
                            ),
                            hintText: 'Dirección',
                            keyboardType: TextInputType.text,
                            onChanged: (value) => context
                                .read<CreateAddresBloc>()
                                .add(CreateAddresEvent.changeAddress(
                                    address: value)),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: Key('city_field'),
                            prefixIcon: Icon(
                              Icons.location_city_outlined,
                              color: MyColors.violetBlue,
                              size: responsive.dp(2.5),
                            ),
                            hintText: 'Ciudad',
                            keyboardType: TextInputType.text,
                            onChanged: (value) => context
                                .read<CreateAddresBloc>()
                                .add(CreateAddresEvent.changeCity(city: value)),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: Key('state_field'),
                            prefixIcon: Icon(
                              Icons.location_city_outlined,
                              color: MyColors.violetBlue,
                              size: responsive.dp(2.5),
                            ),
                            hintText: 'Estado',
                            keyboardType: TextInputType.text,
                            onChanged: (value) => context
                                .read<CreateAddresBloc>()
                                .add(CreateAddresEvent.changeDepartment(
                                    department: value)),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: Key('zip_code_field'),
                            prefixIcon: Icon(
                              Icons.add_home_work_sharp,
                              color: MyColors.violetBlue,
                              size: responsive.dp(2.5),
                            ),
                            hintText: 'Código Postal',
                            keyboardType: TextInputType.number,
                            onChanged: (value) => context
                                .read<CreateAddresBloc>()
                                .add(CreateAddresEvent.changeZipCode(
                                    zipCode: value)),
                          ),
                          SizedBox(height: responsive.hp(4)),
                          state.status == CreateAddresEventEnum.loading
                              ? CircularProgressIndicator()
                              : CustomPrimaryButton(
                                  key: Key('create_address_button'),
                                  text: 'Crear dirección',
                                  onPressed: () {
                                    context
                                        .read<CreateAddresBloc>()
                                        .add(CreateAddresEvent.createAddres());
                                  })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
