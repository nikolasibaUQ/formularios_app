import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/home/presentation/pages/home_page.dart';
import 'package:formularios_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:formularios_app/features/register/presentation/pages/register_page.dart';
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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String routeName = '/login';
  static String routePath = '/';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.loginState == LoginStateEnum.success) {
          CustomDialog(
              context: context,
              title: 'Éxito',
              subtitle: 'Inicio de sesión correcto',
              icon: Image.asset(Paths.images.success),
              onClose: () {
                context.read<LoginBloc>().add(const LoginEvent.deleteState());
                GoRouter.of(context).goNamed(HomePage.routeName);
              });
        } else if (state.loginState == LoginStateEnum.error) {
          CustomDialog(
              context: context,
              title: 'Error',
              subtitle: 'Correo o contraseña incorrectos',
              onClose: () {
                context.read<LoginBloc>().add(const LoginEvent.deleteState());
              });
        } else if (state.loginState == LoginStateEnum.emptyEmail) {
          CustomDialog(
            context: context,
            title: 'Error',
            subtitle: 'El correo no puede estar vacío',
            onClose: () =>
                context.read<LoginBloc>().add(const LoginEvent.deleteState()),
          );
        } else if (state.loginState == LoginStateEnum.emptyPassword) {
          CustomDialog(
              context: context,
              title: 'Error',
              subtitle: 'La contraseña no puede estar vacía',
              onClose: () {
                context.read<LoginBloc>().add(const LoginEvent.deleteState());
              });
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return BackGround(
            child: Positioned(
              top: responsive.hp(28),
              left: responsive.wp(7),
              height: responsive.hp(55),
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
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: responsive.fp(28),
                            color: MyColors.violetBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: responsive.hp(4)),
                        Text(
                          'Iniciar Sesión',
                          style: TextStyles.dynamicTextStyle(
                            fontFamily: Fonts.montserratMedium,
                            fontSize: responsive.fp(19),
                          ),
                        ),
                        SizedBox(height: responsive.hp(4)),
                        CustomTextField(
                          key: const Key('emailTextField'),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(LoginEvent.emailChanged(value));
                          },
                          hintText: 'Correo',
                          keyboardType: TextInputType.emailAddress,
                          sufixIcon: Icon(
                            Icons.email_outlined,
                            size: responsive.dp(2),
                            color: MyColors.violetBlue,
                          ),
                        ),
                        SizedBox(height: responsive.hp(4)),
                        CustomTextField(
                          key: const Key('passwordTextField'),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(LoginEvent.passwordChanged(value));
                          },
                          hintText: 'Contraseña',
                          obscureText: true,
                        ),
                        SizedBox(height: responsive.hp(6)),
                        state.loginState == LoginStateEnum.loading
                            ? CircularProgressIndicator()
                            : CustomPrimaryButton(
                                key: const Key('loginBtn'),
                                text: 'Ingresar',
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  context
                                      .read<LoginBloc>()
                                      .add(const LoginEvent.login());
                                },
                                height: responsive.dp(5)),
                        SizedBox(height: responsive.hp(2)),
                        GestureDetector(
                          key: const Key('registerBtn'),
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(RegisterPage.routeName);
                          },
                          child: SizedBox(
                            child: Text(
                              '¿No tienes cuenta? Regístrate',
                              style: TextStyles.dynamicTextStyle(
                                fontFamily: Fonts.montserratMedium,
                                isUnderLine: true,
                                fontSize: responsive.fp(16),
                                color: MyColors.violetBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
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
