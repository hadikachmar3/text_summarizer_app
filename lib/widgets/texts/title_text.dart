import 'package:flutter/cupertino.dart';

import '../../services/utils.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget({
    Key? key,
    required this.label,
    this.fontSize = 20,
    this.color,
    this.maxLines,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      // textAlign: TextAlign.justify,
      style: TextStyle(
        color: color ?? Utils(context).color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
