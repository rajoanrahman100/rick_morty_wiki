import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container_cast_item.dart';
import 'package:ricky_morty_wiki/features/home/model/favourite_character_result.dart';

import '../../cast/model/character_model.dart';


class CastItemWidget extends StatelessWidget {
   CastItemWidget({
    super.key,
    required this.data,
    required this.height,
    required this.width,
    this.callBackCastFavourite,
    this.callBackCastDetails,

  });

  final CharactersResult data;

  final double? height;
  final double? width;
  final VoidCallback? callBackCastFavourite;
  final VoidCallback? callBackCastDetails;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderPainter(),
      child: ClipPath(
        clipper: AngledBottomRightCorner(),
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child:Stack(
                  children: [
                    GestureDetector(
                      onTap: callBackCastDetails,
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
                    GestureDetector(
                      onTap: callBackCastFavourite,
                      child: Container(
                        decoration:  BoxDecoration(
                          color: AppColors.black.withOpacity(0.2),
                          borderRadius:  const BorderRadius.all(Radius.circular(3)),
                        ),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(Icons.star_border_outlined, color: AppColors.black),
                      ),
                    )
                  ]
                )
              ),
              const Gap(10),
              Text(data.name ?? "", style: bodyMedium12),
            ]),
          ),
        ),
      ),
    );
  }
}