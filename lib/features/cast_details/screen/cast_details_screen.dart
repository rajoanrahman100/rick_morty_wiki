import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_cubit.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_state.dart';
import 'package:ricky_morty_wiki/features/cast_details/model/cast_details_model.dart';
import 'package:ricky_morty_wiki/features/cast_details/widget/details_item_container_widget.dart';
import 'package:ricky_morty_wiki/features/cast_details/widget/episode_list_item_widget.dart';

class CastDetailsScreen extends StatefulWidget {
  @override
  State<CastDetailsScreen> createState() => _CastDetailsScreenState();
}

class _CastDetailsScreenState extends State<CastDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    AppSize.initialize(context);
    double? width = AppSize.screenWidth;
    double? height = AppSize.screenHeight;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(),
        body: Stack(alignment: Alignment.center, children: [
          BackgoundImageOverlay(height: height, width: width),
          Container(
              height: height,
              width: width,
              color: AppColors.backgroundColor.withOpacity(0.9),
              padding: const EdgeInsets.all(24.0),
              child: BlocBuilder<CastDetailsCubit, CastDetailsState>(builder: (context, state) {
                if (state is CastDetailsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CastDetailsLoadedState) {
                  var data = state.castDetailsModel.data!.character!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          data.name!,
                          style: titleMedium22.copyWith(color: AppColors.filterBackgroundColor),
                        ),
                        const Gap(20),
                        Container(
                          padding: const EdgeInsets.all(25.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                                AppColors.gdBluishCyan,
                                AppColors.gdYellowGreen,
                              ]),
                              width: 0.5,
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data.image ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const CircularProgressIndicator(),
                          ),
                        ),
                        const Gap(20),
                        Row(children: [
                          Expanded(
                            child: CastDetailsItemContainer(
                              itemName: data.status!,
                              assetName: AppAssets.status,
                              itemTitle: "Status",
                            ),
                          ),
                          const Gap(15.0),
                          Expanded(
                            child: CastDetailsItemContainer(
                              itemName: data.species!,
                              assetName: AppAssets.species,
                              itemTitle: "Species",
                            ),
                          ),
                          const Gap(15.0),
                          Expanded(
                            child: CastDetailsItemContainer(
                              itemName: data.gender!,
                              assetName: AppAssets.gender,
                              itemTitle: "Gender",
                            ),
                          ),
                        ]),
                        const Gap(15.0),
                        CastDetailsItemContainer(
                          itemName: data.origin!.name!,
                          assetName: AppAssets.origin,
                          itemTitle: "Origin",
                          width: width,
                        ),
                        const Gap(15.0),
                        CastDetailsItemContainer(
                          itemName: data.location!.name!,
                          assetName: AppAssets.lastLocation,
                          itemTitle: "Last Known Location",
                          width: width,
                        ),
                        const Gap(15.0),
                        EpisodeListItemWidget(width: width, data: data),
                      ],
                    ),
                  );
                } else if (state is CastDetailsErrorState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container();
              }))
        ]));
  }
}


