import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';

class CastDetailsItemContainer extends StatelessWidget {
  String? itemName;
  String? assetName;
  String? itemTitle;

  double? width;

  CastDetailsItemContainer({this.itemName, this.assetName, this.itemTitle,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: AppColors.filterBackgroundColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SvgPicture.asset(
          assetName!,
        ),
        Gap(10.0),
        Text(itemTitle!, style: bodyRegular10),
        Gap(2.0),
        Text(itemName!, style: bodySemiBold16),
      ]),
    );
  }
}