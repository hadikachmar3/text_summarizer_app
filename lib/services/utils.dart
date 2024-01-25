import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  bool get getTheme => Provider.of<ThemeProvider>(context).getIsDarkTheme;
  Color get color => getTheme ? Colors.white : Colors.black;
  // Size get getScreenSize => MediaQuery.of(context).size; // we can use the screen_size.dart file, and with Flutter 3.10 it is even better.
}
