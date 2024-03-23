import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/features/bottom_nav_bar/bloc/bottomnav_bar_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_character_state.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/cast_item_widget.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_cubit.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_state.dart';

import '../widgets/view_all_container.dart';

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
      context.read<CharacterCubit>().fetchCharacters(currentPage: 1, status: "name", query: "");
      context.read<LocationCubit>().fetchLocations();
      context.read<FavouriteCharactersCubit>().loadObjects();
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
                const Gap(30.0),
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
                BlocBuilder<FavouriteCharactersCubit, FavouriteCharactersState>(builder: (context, state) {

                  if(state is InitialFavouriteCharacterState){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (state is FavouriteCharacterUpdateState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SizedBox(
                        height: 220,
                        width: width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.favouriteCharactersList.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var data = state.favouriteCharactersList[index];
                            return GestureDetector(
                                onTap: () {
                                  context.read<FavouriteCharactersCubit>().removeFavouriteCharacter(id: data.id);
                                },
                                child: Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.white),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
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
                                            Container(
                                              decoration:  BoxDecoration(
                                                color: AppColors.black.withOpacity(0.4),
                                                borderRadius:  BorderRadius.all(Radius.circular(3)),
                                              ),
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(2),
                                              child: Icon(Icons.star, color: AppColors.favouriteColor),
                                            )
                                          ]
                                        ),
                                      ),
                                      const Gap(10),
                                      Text(data.name ?? "", style: bodyMedium12),
                                    ]),
                                  ),
                                ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(24.0);
                          },
                        ),
                      ),
                    );
                  }
                  else if(state is EmptyFavouriteCharacterListState){
                    return const Text("No characters has added yet", style: bodySemiBold12);
                  }
                  return Container();
                }),
                const Gap(30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Meet the cast", style: bodySemiBold16),
                      GestureDetector(
                          onTap: () {
                            context.read<BottomNavBarCubit>().updateTab(NavigationItem.item2);
                          },
                          child: ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                BlocBuilder<CharacterCubit, CharacterSate>(builder: (context, state) {
                  if (state is LoadingCharacterState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ResponseCharacterState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SizedBox(
                        height: 220,
                        width: width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var data = state.characterModel.data!.characters!.results![index];
                            return CastItemWidget(data: data, height: height, width: width);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(24.0);
                          },
                        ),
                      ),
                    );
                  } else if (state is ErrorCharacterState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                }),
                const Gap(30.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Locations", style: bodySemiBold16),
                      ViewAllContainer(),
                    ],
                  ),
                ),
                const Gap(24),
                BlocBuilder<LocationCubit, LocationState>(builder: (context, state) {
                  if (state is LoadingLocationState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ResponseLocationState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SizedBox(
                        height: 70,
                        width: width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var data = state.locationModel.data!.locations!.results![index];
                            return Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.white), borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("#${data.id}", style: bodyMedium12),
                                      const Gap(5),
                                      Text(data.name ?? "", style: bodyMedium12),
                                    ]),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(24.0);
                          },
                        ),
                      ),
                    );
                  } else if (state is ErrorLocationState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                }),
                Gap(30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Episodes", style: bodySemiBold16),
                      ViewAllContainer(),
                    ],
                  ),
                ),
                const Gap(24),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
