import 'package:flutter/material.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';

/// The CustomPrimaryButton class is a stateless widget that displays a
/// The CustomPrimaryButton class is a stateless widget that displays a
/// filled button with a text and an onPressed callback.
class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.height,
      this.width,
      this.textStyle,
      this.hoverTextStyle,
      this.color,
      this.hoverColor,
      this.borderColor,
      this.hoverBorderColor,
      this.haveShadow = true,
      this.fontSizeText,
      this.isDisabled = false,
      this.fontFamily,
      this.padding});

  final bool isDisabled;
  final String text;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final TextStyle? hoverTextStyle;
  final Color? color;
  final Color? hoverColor;
  final Color? hoverBorderColor;
  final Color? borderColor;
  final bool haveShadow;
  final double? fontSizeText;
  final String? fontFamily;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    final isDesktop = responsive.isDesktop;

    return SizedBox(
      height: height,
      width: width ?? responsive.wp(77),
      child: FilledButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets?>(padding),
            elevation: WidgetStateProperty.all(haveShadow ? 1.0 : 0.0),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (isDisabled) {
                return MyColors.grayText;
              }

              if (states.contains(WidgetState.hovered)) {
                return hoverColor ?? MyColors.blueGreen;
              } else {
                return color ?? MyColors.blueGreen;
              }
            }),
            side: WidgetStateProperty.all<BorderSide>(
              BorderSide(color: borderColor ?? Colors.transparent, width: 1),
            )),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ??
              TextStyles.dynamicTextStyle(
                isBold: true,
                color: MyColors.white,
                fontFamily: fontFamily ?? Fonts.mPLUSRounded1cBold,
                fontSize: fontSizeText ??
                    (isDesktop ? responsive.fpw(16) : responsive.fp(16)),
              ),
        ),
      ),
    );
  }
}
