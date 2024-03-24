import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container_other_item.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_cubit.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_state.dart';


class EpisodeListBuilder extends StatelessWidget {


  const EpisodeListBuilder({
    super.key,
    required this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: BlocBuilder<EpisodeCubit, EpisodeState>(builder: (context, state) {
        if (state is LoadingEpisodeState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ResponseEpisodeState) {
          return SizedBox(
            height: 70,
            width: width,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                var data = state.episodeModel.data!.episodes!.results![index];
                return CustomPaint(
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
                              Text("${data.episode}", style: bodyMedium10),
                              const Gap(5),
                              Text(data.name ?? "", style: bodySemiBold12),
                            ]),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(24.0);
              },
            ),
          );
        } else if (state is ErrorEpisodeState) {
          return Center(child: Text(state.error));
        }
        return Container();
      }),
    );
  }
}