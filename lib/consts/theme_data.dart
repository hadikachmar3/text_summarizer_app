import 'package:flutter/material.dart';

import 'app_color.dart';

class Styles {
  static ThemeData themeData({
    required bool isDarkTheme,
    required BuildContext context,
    required ColorScheme colorScheme,
  }) {
    final textBorderRadius = BorderRadius.circular(3);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDarkTheme
          ? AppColor.darkScaffoldColor
          : AppColor.lightScaffoldColor,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme
            ? AppColor.darkScaffoldColor
            : AppColor.lightScaffoldColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDarkTheme ? Colors.green.shade800 : Colors.green.shade200,
          foregroundColor: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor:
              isDarkTheme ? Colors.green.shade200 : Colors.green.shade800,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDarkTheme ? Colors.grey.shade800 : Colors.white70,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.green.shade400,
          ),
          borderRadius: textBorderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.green.shade400,
          ),
          borderRadius: textBorderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: textBorderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: textBorderRadius,
        ),
      ),
    );
  }
}
