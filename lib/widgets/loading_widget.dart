import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../services/assets_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.loaderSize = 40});
  final double loaderSize;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.appLogo,
            height: 50,
            width: 50,
          ),
          Lottie.asset(
            AssetsManager.loader,
            height: 130,
            width: 130,
          ),
        ],
      ),
    );
  }
}
