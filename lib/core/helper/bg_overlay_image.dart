import 'package:flutter/material.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';

class BackgoundImageOverlay extends StatelessWidget {
  const BackgoundImageOverlay({
    super.key,
    required this.height,
    required this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        AppAssets.bgOverlayImage,
        fit: BoxFit.fill,
      ),
    );
  }
}