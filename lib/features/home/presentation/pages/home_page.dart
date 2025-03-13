import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formularios_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';
import 'package:formularios_app/shared/widgets/background.dart';

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
      listener: (context, state) {},
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BackGround(
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Bienvenido de nuevo \nAqui estan todas tus direcciones registradas',
                            textAlign: TextAlign.center,
                            style: TextStyles.dynamicTextStyle(
                                isBold: true,
                                lineSpacing: 1.5,
                                fontFamily: Fonts.mPLUSRounded1cMedium,
                                fontSize: responsive.fp(22),
                                color: MyColors.violetBlue),
                          ),
                          SizedBox(height: responsive.hp(8)),

                          // Lista de direcciones
                          if (state.addresses.isNotEmpty)
                            Column(
                              children: state.addresses
                                  .map(
                                    (e) => ListTile(
                                      title: Text(e.address),
                                      subtitle: Text(e.city),
                                    ),
                                  )
                                  .toList(),
                            )
                          else
                            Text(
                              'No tienes direcciones registradas',
                              style: TextStyles.dynamicTextStyle(
                                  isBold: true,
                                  fontFamily: Fonts.mPLUSRounded1cMedium,
                                  fontSize: responsive.fp(18),
                                  color: MyColors.violetBlue),
                            ),
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
