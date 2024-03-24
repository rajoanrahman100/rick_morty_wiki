import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container_other_item.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_cubit.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_state.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_cubit.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_state.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initialize(context);
    double? width = AppSize.screenWidth;
    double? height = AppSize.screenHeight;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          BackgoundImageOverlay(height: height, width: width),
          Container(
            height: height,
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 24.0),
            color: AppColors.backgroundColor.withOpacity(0.9),
            child: SingleChildScrollView(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("All Locations", style: bodySemiBold16.copyWith(color: AppColors.filterBackgroundColor)),
                  const Gap(20),
                  BlocBuilder<EpisodeCubit,EpisodeState>(
                    builder: (context,state){
                      if(state is LoadingEpisodeState){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      }else if (state is ResponseEpisodeState){
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: (state.episodeModel.data!.episodes!.results!.length / 2).ceil(),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_,index){
                            int firstIndex = index * 2;
                            int secondIndex = index * 2 + 1;

                            // Check if the second index exceeds the length of the data list
                            // If it does, only display the first item in the row
                            bool hasSecondItem = secondIndex < state.episodeModel.data!.episodes!.results!.length;

                            var data=state.episodeModel.data!.episodes!.results!;
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: CustomPaint(
                                      painter: BorderCustomPainter(),
                                      child: ClipPath(
                                        clipper: CustomAngledBottomRightCorner(),
                                        child: SizedBox(
                                          width: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("${data[firstIndex].episode}", style: bodyMedium12),
                                                  const Gap(5),
                                                  Text(data[firstIndex].name ?? "", style: bodyMedium12,maxLines: 1,),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (hasSecondItem)
                                  const Gap(20),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: CustomPaint(
                                      painter: BorderCustomPainter(),
                                      child: ClipPath(
                                        clipper: CustomAngledBottomRightCorner(),
                                        child: SizedBox(
                                          width: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("${data[secondIndex].episode}", style: bodyMedium12),
                                                  const Gap(5),
                                                  Text(data[secondIndex].name ?? "", style: bodyMedium12,maxLines: 1,),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
