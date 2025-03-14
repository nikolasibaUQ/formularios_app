import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/register/presentation/bloc/register_bloc.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/path_images.dart';
import 'package:formularios_app/shared/utils/responsive.dart';
import 'package:formularios_app/shared/widgets/background.dart';
import 'package:formularios_app/shared/widgets/custom_dialog.dart';
import 'package:formularios_app/shared/widgets/custom_primary_button.dart';
import 'package:formularios_app/shared/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static String routeName = '/register';
  static String routePath = '/register';
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.registerAlert == RegisterAlerts.success) {
          CustomDialog(
              context: context,
              title: 'Éxito',
              subtitle: 'Registro completado',
              icon: Image.asset(Paths.images.success),
              onClose: () {
                context
                    .read<RegisterBloc>()
                    .add(const RegisterEvent.deleteAlert());

                context.pop();
              });
        } else if (state.registerAlert == RegisterAlerts.error) {
          CustomDialog(
              context: context,
              title: 'Error',
              subtitle: state.message,
              onClose: () {
                context
                    .read<RegisterBloc>()
                    .add(const RegisterEvent.deleteAlert());
              });
        } else if (state.registerAlert == RegisterAlerts.emptyFields) {
          CustomDialog(
            context: context,
            title: 'Error',
            subtitle: 'Por favor, llena todos los campos',
            onClose: () => context
                .read<RegisterBloc>()
                .add(const RegisterEvent.deleteAlert()),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return BackGround(
            canBack: true,
            child: Positioned(
              top: responsive.hp(28),
              left: responsive.wp(7),
              height: responsive.hp(67),
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
                    child: SingleChildScrollView(
                      key: const Key('register_form'),
                      child: Column(
                        children: [
                          Text(
                            'Registrate',
                            style: TextStyle(
                              fontSize: responsive.fp(28),
                              color: MyColors.violetBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: const Key('nameTextField'),
                            onChanged: (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterEvent.nameChanged(value));
                            },
                            hintText: 'Nombre',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              size: responsive.dp(2),
                              color: MyColors.violetBlue,
                            ),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: const Key('lastNameTextField'),
                            onChanged: (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterEvent.lastNameChanged(value));
                            },
                            hintText: 'Apellido',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              size: responsive.dp(2),
                              color: MyColors.violetBlue,
                            ),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: const Key('birthdayTextField'),
                            onChanged: (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterEvent.changeBirthDate(value));
                            },
                            hintText: 'Fecha de nacimiento',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: responsive.dp(2),
                              color: MyColors.violetBlue,
                            ),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: const Key('emailTextField'),
                            onChanged: (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterEvent.emailChanged(value));
                            },
                            hintText: 'Correo',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: responsive.dp(2),
                              color: MyColors.violetBlue,
                            ),
                          ),
                          SizedBox(height: responsive.hp(3)),
                          CustomTextField(
                            key: const Key('passwordTextField'),
                            onChanged: (value) {
                              context
                                  .read<RegisterBloc>()
                                  .add(RegisterEvent.passwordChanged(value));
                            },
                            hintText: 'Contraseña',
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                          ),
                          SizedBox(height: responsive.hp(5)),
                          state.registerAlert == RegisterAlerts.loading
                              ? CircularProgressIndicator()
                              : CustomPrimaryButton(
                                  key: const Key('register_button'),
                                  text: 'Registrarse',
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    context
                                        .read<RegisterBloc>()
                                        .add(const RegisterEvent.register());
                                  },
                                  height: responsive.dp(5)),
                          SizedBox(height: responsive.hp(2)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
