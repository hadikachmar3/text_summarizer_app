import 'package:flutter/material.dart';

import '../../services/assets_manager.dart';
import '../texts/subtitle_text.dart';

class ErrorOrWarningDialogWidget extends StatelessWidget {
  const ErrorOrWarningDialogWidget(
      {super.key,
      required this.subtitle,
      required this.fct,
      this.iconData,
      this.color});
  final String subtitle;
  final Function fct;
  final bool isError = false;
  final IconData? iconData;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isError ? AssetsManager.error : AssetsManager.warning,
            height: 60,
            width: 60,
          ),
          const SizedBox(
            height: 15,
          ),
          SubtitlesTextWidget(
            label: subtitle,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isError)
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: SubtitlesTextWidget(
                    color: Colors.cyan,
                    label: 'Cancel'.toUpperCase(),
                    fontSize: 18,
                  ),
                ),
              TextButton(
                onPressed: () {
                  fct();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const SubtitlesTextWidget(
                  color: Colors.red,
                  label: 'OK',
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
