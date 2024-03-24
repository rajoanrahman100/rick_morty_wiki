import 'package:flutter/material.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';

void showSnackBar(BuildContext context, String message,IconData iconData) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: bodySemiBold12,
          ),
          Icon(iconData,color: AppColors.white,)
        ],
      ),
      duration: const Duration(milliseconds: 1000),
    ),
  );
}
