import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/cast_item_widget.dart';

class CastScreen extends StatefulWidget {
  @override
  State<CastScreen> createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> {
  final ScrollController _scrollController = ScrollController();

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
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            color: AppColors.backgroundColor.withOpacity(0.9),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: width,
                    color: AppColors.backgroundColor,
                  ),
                  Gap(30.0),
                  Text("All Casts", style: bodySemiBold16.copyWith(color: AppColors.filterBackgroundColor)),
                  Gap(20.0),
                  BlocBuilder<CharacterCubit, CharacterSate>(builder: (context, state) {
                    if (state is LoadingCharacterState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ResponseCharacterState) {
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            controller: _scrollController,
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(state.characterModel.data!.characters!.results!.length, (index) {
                              if (index < state.characterModel.data!.characters!.results!.length) {
                                var data = state.characterModel.data!.characters!.results![index];
                                return CastItemWidget(data: data, height: height, width: width);
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            }),
                          );
                        } else {
                          // Tab layout
                          return GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            crossAxisCount: 4,
                            // Adjust the crossAxisCount for tab view
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(state.characterModel.data!.characters!.results!.length, (index) {
                              var data = state.characterModel.data!.characters!.results![index];
                              return CastItemWidget(data: data, height: height, width: width);
                            }),
                          );
                        }
                      });
                    } else if (state is ErrorCharacterState) {
                      return Center(child: Text(state.error));
                    }
                    return Container();
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
