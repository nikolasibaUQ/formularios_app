import 'package:flutter/material.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/path_images.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';

/// The `CustomDialog` class in Dart represents a customizable alert dialog that can be shown in a
/// the application.
class CustomDialog {
  final BuildContext context;
  final Widget? icon;
  final String? title;
  final String? subtitle;
  final VoidCallback? onClose;
  final bool barrierDismissible;
  final double? width;

  CustomDialog(
      {required this.context,
      this.icon,
      this.title,
      this.subtitle,
      this.onClose,
      this.width,
      this.barrierDismissible = false}) {
    showAlertDialog();
  }

  void showAlertDialog() {
    final responsive = Responsive(context);
    final bool isDesktop = responsive.isDesktop;
    showDialog(
        context: context,
        builder: (context) => PopScope(
              canPop: barrierDismissible,
              child: Center(
                child: Container(
                  key: const Key('dialog_content'),
                  padding: EdgeInsets.only(
                      left: responsive.dp(0.5),
                      right: responsive.dp(0.5),
                      top: responsive.dp(0.5),
                      bottom: responsive.dp(isDesktop ? 2 : 3.5)),
                  width: width ?? responsive.dp(isDesktop ? 20 : 30),
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          key: const Key('alert_close_button'),
                          color: MyColors.white,
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.close_rounded),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  MyColors.violetBlue)),
                          onPressed: () {
                            Navigator.pop(context);
                            if (onClose != null) onClose!();
                          },
                        ),
                      ),
                      SizedBox(
                        width: responsive.dp(isDesktop ? 5 : 8.8),
                        height: responsive.dp(isDesktop ? 5 : 8.8),
                        child: icon ?? Image.asset(Paths.images.error),
                      ),
                      if (title != null) SizedBox(height: responsive.dp(1.5)),
                      if (title != null)
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyles.dynamicTextStyle(
                              fontSize: responsive.fp(19),
                              color: MyColors.violetBlue,
                              fontFamily: Fonts.mPLUSRounded1cExtraBold),
                        ),
                      if (subtitle != null)
                        SizedBox(height: responsive.dp(1.5)),
                      if (subtitle != null)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive.dp(0.5)),
                          child: Text(
                            subtitle!,
                            textAlign: TextAlign.center,
                            style: TextStyles.dynamicTextStyle(
                                lineSpacing: 1.2,
                                fontSize: responsive.fp(16),
                                color: MyColors.violetBlue,
                                fontFamily: Fonts.montserratRegular),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        barrierDismissible: barrierDismissible);
  }
}
