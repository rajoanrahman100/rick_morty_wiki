import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';

import '../../cast/model/character_model.dart';


class CastItemWidget extends StatelessWidget {
  const CastItemWidget({
    super.key,
    required this.data,
    required this.height,
    required this.width,
  });

  final CharactersResult data;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.white), borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 2,
            child: CachedNetworkImage(
              imageUrl: data.image ?? "",
              imageBuilder: (context, imageProvider) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Gap(10),
          Text(data.name ?? "", style: bodyMedium12),
        ]),
      ),
    );
  }
}