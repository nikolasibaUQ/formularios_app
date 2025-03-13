import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/register/presentation/bloc/register_bloc.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/path_images.dart';
import 'package:formularios_app/shared/utils/responsive.dart';
import 'package:formularios_app/shared/widgets/custom_dialog.dart';
import 'package:formularios_app/shared/widgets/custom_primary_button.dart';
import 'package:formularios_app/shared/widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
              subtitle: 'Inicio de sesión correcto',
              icon: Image.asset(Paths.images.success),
              onClose: () {
                context
                    .read<RegisterBloc>()
                    .add(const RegisterEvent.deleteAlert());
              });
        } else if (state.registerAlert == RegisterAlerts.error) {
          CustomDialog(
              context: context,
              title: 'Error',
              subtitle: 'Ocurrió un error, intenta de nuevo',
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
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: responsive.hp(35),
                        color: MyColors.violetBlue,
                      ),
                      Container(
                        height: responsive.hp(65),
                        color: MyColors.background,
                      ),
                    ],
                  ),
                  Positioned(
                      top: responsive.hp(10),
                      left: responsive.wp(26),
                      child: Container(
                        width: responsive.dp(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive.dp(2),
                              vertical: responsive.dp(2)),
                          child: Image.asset(
                            Paths.images.form,
                            color: MyColors.violetBlue,
                            fit: BoxFit.contain,
                            height: responsive.dp(10),
                          ),
                        ),
                      )),
                  Positioned(
                    top: responsive.hp(28),
                    left: responsive.wp(7),
                    height: responsive.hp(65),
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
                                  context.read<RegisterBloc>().add(
                                      RegisterEvent.lastNameChanged(value));
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
                                  context.read<RegisterBloc>().add(
                                      RegisterEvent.changeBirthDate(value));
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
                                  context.read<RegisterBloc>().add(
                                      RegisterEvent.passwordChanged(value));
                                },
                                hintText: 'Contraseña',
                                keyboardType: TextInputType.emailAddress,
                                obscureText: true,
                              ),
                              SizedBox(height: responsive.hp(5)),
                              state.registerAlert == RegisterAlerts.loading
                                  ? CircularProgressIndicator()
                                  : CustomPrimaryButton(
                                      text: 'Ingresar',
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        context.read<RegisterBloc>().add(
                                            const RegisterEvent.register());
                                      },
                                      height: responsive.dp(5)),
                              SizedBox(height: responsive.hp(2)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
