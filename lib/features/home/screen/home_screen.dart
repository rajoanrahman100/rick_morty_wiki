import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/view_all_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<CharacterCubit>();
      cubit.fetchCharacters();
    });
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(24.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Favorite", style: bodySemiBold16),
                      ViewAllContainer(),
                    ],
                  ),
                ),
                const Gap(24),
                Container(
                  width: width,
                  height: height! * 0.12,
                  color: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                ),
                const Gap(24.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Meet the cast", style: bodySemiBold16),
                      ViewAllContainer(),
                    ],
                  ),
                ),
                const Gap(24),
                BlocBuilder<CharacterCubit, CharacterSate>(builder: (context, state) {
                  if (state is LoadingCharacterState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ResponseCharacterState) {
                    return SizedBox(
                      height: 220,
                      width: width,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          var data = state.characterModel.data!.characters!.results![index];
                          return Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.white),
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CachedNetworkImage(
                                      imageUrl:data.image ?? "",
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
                                  Text(data.name ?? "",style: bodyMedium12),
                                ]
                              ),
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                          return const Gap(24.0);
                      },
                      ),
                    );
                  } else if (state is ErrorCharacterState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                }),
                Gap(10.0),

              ],
            ),
          ),
        )
      ]),
    );
  }
}
