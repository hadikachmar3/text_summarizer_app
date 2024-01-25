import 'package:flutter/material.dart';

import '../consts/constants.dart';

class Vspace extends StatelessWidget {
  const Vspace({super.key, this.height = Constants.defaultVMargin});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class Wspace extends StatelessWidget {
  const Wspace({super.key, this.width = Constants.defaultVMargin});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
