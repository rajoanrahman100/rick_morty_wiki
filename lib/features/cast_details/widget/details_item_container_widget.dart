import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';

class CastDetailsItemContainer extends StatelessWidget {
  String? itemName;
  String? assetName;
  String? itemTitle;
  bool? isEditIconShow;
  double? width;

  CastDetailsItemContainer({this.itemName, this.assetName, this.itemTitle, this.width, this.isEditIconShow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: AppColors.filterBackgroundColor),
      ),
      child: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SvgPicture.asset(
              assetName!,
            ),
            Gap(20.0),
            Text(itemTitle!, style: bodyRegular10),
            Gap(2.0),
            Text(
              itemName!,
              style: bodySemiBold16,
              maxLines: 1,
            ),
          ]),
          isEditIconShow! ? Positioned(bottom: 10.0, right: 10.0,child: SvgPicture.asset(AppAssets.edit)) : Container(),
        ],
      ),
    );
  }
}
