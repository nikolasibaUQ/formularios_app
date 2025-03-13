import 'package:flutter/material.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';

class OptionContainer extends StatelessWidget {
  const OptionContainer(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final Icon icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: responsive.dp(1)),
        color: MyColors.transparentViolet,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          // side: BorderSide(color: MyColors.violetBlue, width: 0.5),
        ),
        child: Container(
          padding: EdgeInsets.all(responsive.dp(2)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: MyColors.white,
          ),
          height: responsive.hp(12),
          width: responsive.wp(80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              SizedBox(width: responsive.wp(10)),
              Flexible(
                child: Text(title,
                    style: TextStyles.dynamicTextStyle(
                      fontFamily: Fonts.montserratMediumItalic,
                      fontSize: responsive.fp(18),
                      lineSpacing: 1.2,
                      color: MyColors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
