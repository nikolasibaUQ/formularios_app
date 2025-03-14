import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/create_address/presentation/pages/create_addres_page.dart';
import 'package:formularios_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:formularios_app/features/home/presentation/widgets/direction_content.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';
import 'package:formularios_app/shared/widgets/background.dart';
import 'package:formularios_app/shared/widgets/custom_dialog.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String routeName = '/home';
  static String routePath = '/home';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return BlocListener<HomeBloc, HomeState>(
      bloc: context.read<HomeBloc>()..add(const HomeEvent.started()),
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.alert == HomeStateAlerts.error) {
          CustomDialog(
              context: context,
              title: 'Error',
              subtitle: 'No se pudo eliminar la dirección',
              onClose: () {
                context.read<HomeBloc>().add(const HomeEvent.deleteAler());
              });
        } else if (state.alert == HomeStateAlerts.deleteAddress) {
          CustomDialog(
              context: context,
              title: 'Éxito',
              subtitle: 'Dirección eliminada correctamente',
              onClose: () {
                context.read<HomeBloc>().add(const HomeEvent.deleteAler());
              });
        } else if (state.alert == HomeStateAlerts.errorGetAddress) {
          CustomDialog(
              context: context,
              title: 'Error',
              subtitle: 'No se pudo obtener las direcciones',
              onClose: () {
                context.read<HomeBloc>()
                  ..add(const HomeEvent.deleteAler())
                  ..add(const HomeEvent.started());
              });
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BackGround(
            floatingActionButton: FloatingActionButton(
              key: const Key('add_address_button'),
              onPressed: () {
                GoRouter.of(context).pushNamed(CreateAddressPage.routeName);
              },
              child: Icon(Icons.add),
            ),
            leftHeaderWidget: responsive.wp(12),
            topHeaderWidget: responsive.hp(8),
            headerWidget: Text(
              'Bienvenido de nuevo\n'
              '${state.userData?.name ?? ''} ${state.userData?.lastName ?? ''}\n'
              'Aquí están todas tus\n direcciones registradas.',
              style: TextStyles.dynamicTextStyle(
                isBold: true,
                lineSpacing: 1.5,
                fontFamily: Fonts.mPLUSRounded1cMedium,
                fontSize: responsive.fp(24),
                color: MyColors.white,
              ),
              textAlign: TextAlign.center, //
              softWrap: true, //
              overflow: TextOverflow.visible, //
            ),
            child: Positioned(
              left: responsive.wp(2.5),
              top: responsive.hp(28),
              height: responsive.hp(70),
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
                    child: state.userData?.addresses != null &&
                            state.userData!.addresses!.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                state.userData!.addresses!.length,
                                (index) => DirectionContent(
                                  address: state.userData!.addresses![index],
                                  onTap: () {
                                    context.read<HomeBloc>().add(
                                          HomeEvent.deleteAddress(index: index),
                                        );
                                  },
                                ),
                              ),
                            ),
                          )
                        : Text(
                            'No tienes direcciones registradas',
                            style: TextStyles.dynamicTextStyle(
                                isBold: true,
                                fontFamily: Fonts.mPLUSRounded1cMedium,
                                fontSize: responsive.fp(18),
                                color: MyColors.violetBlue),
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
