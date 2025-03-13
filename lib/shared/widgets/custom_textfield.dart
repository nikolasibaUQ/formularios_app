import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formularios_app/shared/colors/colors.dart';
import 'package:formularios_app/shared/styles/text_styles.dart';
import 'package:formularios_app/shared/utils/fonts_names.dart';
import 'package:formularios_app/shared/utils/responsive.dart';

/// The CustomTextField class is a stateful widget that displays a
/// custom textfield according to the design.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.enableInteractiveSelection = true,
    this.enabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.maxLength,
    this.onChanged,
    this.sufixIcon,
    this.inputFormatters,
    this.hintTextStyle,
    this.textStyle,
    this.fillColor,
    this.withShadow = true,
    this.suffixIconSize,
    this.maxHeight,
    this.maxWidth,
    this.borderSide,
    this.focusedBorderSide,
    this.fontSizeText,
    this.sizeletterpassword,
    this.elevation = 3,
    this.minWidth = 0,
    this.minHeight = 0,
    this.borderRadius,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool enableInteractiveSelection;
  final bool enabled;
  final bool obscureText;
  final Widget? prefixIcon;
  final int? maxLength;
  final Widget? sufixIcon;
  final Function(String)? onChanged;

  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Color? fillColor;
  final bool withShadow;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;

  final double? suffixIconSize;
  final double? fontSizeText;
  final double? maxWidth;
  final double? maxHeight;
  final double? sizeletterpassword;

  final double elevation;
  final double minWidth;
  final double minHeight;
  final BorderRadiusGeometry? borderRadius;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureTextState;

  @override
  void initState() {
    super.initState();
    _obscureTextState = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final isDesktop = responsive.isDesktop;

    return Material(
      elevation: widget.elevation,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
      color: Colors.transparent,
      shadowColor: Colors.grey.withValues(alpha: widget.withShadow ? 0.4 : 0),
      child: TextFormField(
        readOnly: widget.readOnly,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureTextState,
        maxLines: 1,
        maxLength: widget.maxLength,
        buildCounter: (BuildContext context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        style: widget.textStyle ??
            TextStyles.dynamicTextStyle(
                fontFamily: Fonts.montserratRegular,
                fontSize: widget.sizeletterpassword ??
                    (isDesktop ? responsive.fpw(16) : responsive.fp(16))),
        decoration: InputDecoration(
            filled: true,
            isDense: true,
            fillColor: widget.fillColor ?? MyColors.background,
            hoverColor: widget.readOnly ? Colors.transparent : null,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ??
                TextStyles.dynamicTextStyle(
                  fontFamily: Fonts.montserratRegular,
                  color: MyColors.violetBlue,
                  fontSize: widget.fontSizeText ??
                      (isDesktop
                          ? responsive.fpw(15)
                          : responsive.isLandscape
                              ? responsive.fp(15)
                              : responsive.fp(16)),
                ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: widget.focusedBorderSide ??
                    BorderSide(color: MyColors.violetBlue, width: 1)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: widget.borderSide ??
                    BorderSide(color: MyColors.grayViolet, width: 0),
                borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.symmetric(horizontal: responsive.dp(3)),
            constraints: BoxConstraints(
                minHeight: widget.minHeight,
                minWidth: widget.minWidth,
                maxWidth: widget.maxWidth ?? responsive.wp(78),
                maxHeight: widget.maxHeight ?? responsive.hp(5.5)),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: widget.prefixIcon,
                  ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    padding: EdgeInsets.only(
                        right: responsive.dp(2), left: responsive.dp(1)),
                    icon: Icon(
                      !_obscureTextState
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: MyColors.violetBlue,
                      size: widget.suffixIconSize ??
                          (isDesktop ? responsive.dp(1.5) : responsive.dp(2)),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextState = !_obscureTextState;
                      });
                    })
                : widget.sufixIcon),
      ),
    );
  }
}
