import 'package:flutter/material.dart';
import 'package:formularios_app/shared/colors/colors.dart';

/// The `CustomProgressDialog` class in Dart displays a custom dialog with a loading indicator in a
/// specified `BuildContext`.
class CustomProgressDialog {
  CustomProgressDialog({required BuildContext context}) {
    showCustomDialogLoading(context: context);
  }

  static void showCustomDialogLoading({required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        barrierColor: MyColors.gray.withValues(alpha: 0.5),
        context: context,
        builder: (builder) {
          return const Center(child: CircularProgressIndicator());
        });
  }
}
