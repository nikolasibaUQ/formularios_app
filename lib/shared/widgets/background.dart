import 'package:flutter/material.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/path_images.dart';
import 'package:formularios_app/shared/utils/responsive.dart';

class BackGround extends StatelessWidget {
  const BackGround(
      {super.key,
      required this.child,
      this.canBack = false,
      this.floatingActionButton,
      this.headerWidget,
      this.topHeaderWidget,
      this.leftHeaderWidget});

  final Widget child;
  final bool canBack;
  final Widget? floatingActionButton;
  final Widget? headerWidget;
  final double? topHeaderWidget;
  final double? leftHeaderWidget;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: responsive.hp(45),
                    color: MyColors.violetBlue,
                  ),
                  Container(
                    height: responsive.hp(55),
                    color: MyColors.background,
                  ),
                ],
              ),
              if (headerWidget != null)
                Positioned(
                  top: topHeaderWidget ?? responsive.hp(10),
                  left: leftHeaderWidget ?? responsive.wp(5),
                  child: headerWidget!,
                ),
              if (headerWidget == null)
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
              if (canBack)
                Positioned(
                  top: responsive.hp(10),
                  left: responsive.wp(5),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: MyColors.white,
                      size: responsive.dp(4),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
