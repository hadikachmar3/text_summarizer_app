import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../consts/constants.dart';
import '../services/assets_manager.dart';
import '../services/utils.dart';
import 'texts/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, this.fontSize = 30.0});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Utils(context).getTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, top: 5, bottom: 5),
              child: Image.asset(
                AssetsManager.appLogo,
                height: kToolbarHeight - 15,
                width: kToolbarHeight - 15,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        FittedBox(
          child: Shimmer.fromColors(
            period: const Duration(seconds: 8),
            baseColor: isDarkTheme
                ? const Color.fromARGB(255, 185, 186, 250)
                : const Color.fromARGB(255, 64, 67, 255),
            highlightColor: Colors.red.shade300,
            child: TitlesTextWidget(
              label: Constants.appName,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
