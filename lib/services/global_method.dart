import 'package:flutter/material.dart';
import '../widgets/dialogs/error_dialog_widget.dart';

class GlobalMethods {
  // The UI widget
  static Future<void> warningOrErrorDialog({
    required String subtitle,
    required Function fct,
    bool isError = false,
    IconData? iconData,
    Color? color,
    required BuildContext context,
  }) async {
    // Adaptive dialog was introduced in Flutter 3.13
    // Using adaptive dialog to it suits all platform
    await showAdaptiveDialog(
        context: context,
        builder: (context) {
          return ErrorOrWarningDialogWidget(
            fct: fct(),
            subtitle: subtitle,
            color: color,
            iconData: iconData,
          );
        });
  }
}
