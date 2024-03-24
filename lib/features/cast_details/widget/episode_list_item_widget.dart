import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/features/cast_details/model/cast_details_model.dart';

class EpisodeListItemWidget extends StatelessWidget {
  const EpisodeListItemWidget({
    super.key,
    required this.width,
    required this.data,
  });

  final double? width;
  final Character data;

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
          AppAssets.episodes,
        ),
        const Gap(10.0),
        const Text("Episode(s)", style: bodyRegular10),
        const Gap(10.0),
        if(data.episode!.isNotEmpty)
          for (var element in data.episode!)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(children: [
                Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.white)),
                const Gap(10.0),
                Expanded(child: Text(element.name!, style: bodySemiBold16,overflow: TextOverflow.ellipsis,)),
              ]),
            )
      ]),
    );
  }
}