import 'package:flutter/material.dart';
import 'package:formularios_app/features/home/presentation/widgets/option_card.dart';
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
                      'Bienvenido de nuevo \n¿Aqui estan todas tus direcciones registradas?',
                      textAlign: TextAlign.center,
                      style: TextStyles.dynamicTextStyle(
                          isBold: true,
                          lineSpacing: 1.5,
                          fontFamily: Fonts.mPLUSRounded1cMedium,
                          fontSize: responsive.fp(22),
                          color: MyColors.violetBlue),
                    ),
                    SizedBox(height: responsive.hp(8)),
                    OptionContainer(
                        title: 'Ver mis direcciones registradas',
                        icon: Icon(
                          Icons.account_balance,
                          size: responsive.dp(4),
                          color: MyColors.violetBlue,
                        ),
                        onTap: () {}),
                    SizedBox(height: responsive.hp(2)),
                    OptionContainer(
                        title: 'Registrar una nueva dirección',
                        icon: Icon(Icons.add_location,
                            size: responsive.dp(4), color: MyColors.violetBlue),
                        onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
