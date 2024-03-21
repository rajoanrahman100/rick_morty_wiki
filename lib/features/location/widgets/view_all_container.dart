import 'package:flutter/material.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';

class ViewAllContainer extends StatelessWidget {
  const ViewAllContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(AppAssets.btnBorderRadius)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5.0),
      child: Center(
        child: Text("View all",style: bodySemiBold12.copyWith(color: AppColors.black),),
      ),
    );
  }
}