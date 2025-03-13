import 'package:flutter/material.dart';

class TextStyles {
  /// The function `dynamicTextStyle` returns a `TextStyle` object with customizable properties such as
  /// color, boldness, underline, line spacing, italic, font size, and font family.
  ///
  /// Args:
  ///   color (Color): The color of the text. If not provided, it defaults to black.
  ///   isBold (bool): A boolean value indicating whether the text should be displayed in bold or not.
  /// If set to true, the text will be displayed in bold. If set to false, the text will be displayed
  /// with normal font weight. The default value is false. Defaults to false
  ///   isUnderLine (bool): A boolean value indicating whether the text should have an underline or not.
  /// If set to true, the text will have an underline, otherwise, it will not have an underline.
  /// Defaults to false
  ///   lineSpacing (double): The lineSpacing parameter is used to specify the height of each line of
  /// text. It determines the amount of space between lines. The default value is 1, which means no
  /// additional space is added between lines. Defaults to 1
  ///   isItalic (bool): A boolean value indicating whether the text should be displayed in italic
  /// style. Defaults to false
  ///   fontSize (double): The `fontSize` parameter is used to specify the size of the text. It is set
  /// to a default value of 100, but you can pass a different value to adjust the font size. Defaults to
  /// 100
  ///   fontFamily (String): The `fontFamily` parameter is a required parameter that specifies the font
  /// family to be used for the text style. It should be a string value representing the name of the
  /// font family.
  ///
  /// Returns:
  ///   a TextStyle object.
  static TextStyle dynamicTextStyle(
      {Color? color,
      bool isBold = false,
      bool isUnderLine = false,
      bool hasThroughLine = false,
      double? lineSpacing = 1,
      bool isItalic = false,
      double fontSize = 100,
      required String fontFamily}) {
    return TextStyle(
        height: lineSpacing,
        decoration: isUnderLine
            ? TextDecoration.combine([
                TextDecoration.underline,
                hasThroughLine
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ])
            : (hasThroughLine
                ? TextDecoration.lineThrough
                : TextDecoration.none),
        decorationColor: color,
        color: color ?? Colors.black,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal);
  }
}
