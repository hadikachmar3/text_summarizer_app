import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeIconWidget extends StatelessWidget {
  const ThemeIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      onPressed: () {
        themeProvider.setDarkTheme(!themeProvider.getIsDarkTheme);
      },
      icon: Icon(
          themeProvider.getIsDarkTheme ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
