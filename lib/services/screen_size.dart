import 'package:flutter/material.dart';

class ScreenSize {
  static Size getScreenSize(BuildContext context) {
    // if Flutter 3.7 and less MediaQuery.of(context).size
    return MediaQuery.sizeOf(context);
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double getScreenAspectRatio(BuildContext context) {
    return MediaQuery.sizeOf(context).aspectRatio;
  }
}
// Size screenSize = WidgetsBinding.instance.window.physicalSize;
// double width = screenSize.width;
// double height = screenSize.height;
