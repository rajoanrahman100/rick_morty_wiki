import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container_cast_item.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container_other_item.dart';

import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/counter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_cubit.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_cubit.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_state.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_character_state.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/cast_item_widget.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_cubit.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_state.dart';

import '../../bottom_nav_bar/bloc_cubit/bottomnav_bar_cubit.dart';
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
      context.read<CounterCubit>().reset();
      context.read<FavouriteCharactersCubit>().loadObjects();
      context.read<EpisodeCubit>().fetchEpisode();
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
          padding: EdgeInsets.all(20.0),
          color: AppColors.backgroundColor.withOpacity(0.9),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Favorite", style: bodySemiBold16),
                      GestureDetector(
                          onTap: () {
                            //context.read<BottomNavBarCubit>().updateTab(NavigationItem.item2);
                            Navigator.of(context).pushNamed('/favourite');
                          },
                          child: const ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: BlocBuilder<FavouriteCharactersCubit, FavouriteCharactersState>(builder: (context, state) {
                    if (state is InitialFavouriteCharacterState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FavouriteCharacterUpdateState) {
                      return SizedBox(
                        height: 220,
                        width: width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.favouriteCharactersList.length>=5?5:state.favouriteCharactersList.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var data = state.favouriteCharactersList[index];
                            return CustomPaint(
                              painter: BorderPainter(),
                              child: ClipPath(
                                clipper: AngledBottomRightCorner(),
                                child: GestureDetector(
                                  onTap: (){
                                    context.read<FavouriteCharactersCubit>().removeFavouriteCharacter(
                                        id: data.id);
                                  },
                                  child: SizedBox(
                                    width: 200,
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Expanded(
                                          flex: 1,
                                          child: Stack(children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed('/cast_details');
                                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                                  context.read<CastDetailsCubit>().fetchCastDetails(id: int.parse(data.id!));
                                                });
                                              },
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
                                              onTap:() {
                                                context.read<FavouriteCharactersCubit>().removeFavouriteCharacter(id: data.id);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.black.withOpacity(0.4),
                                                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                ),
                                                margin: const EdgeInsets.all(5),
                                                padding: const EdgeInsets.all(2),
                                                child: const Icon(Icons.star, color: AppColors.favouriteColor),
                                              ),
                                            )
                                          ]),
                                        ),
                                        const Gap(10),
                                        Text(data.name ?? "", style: bodyMedium12),
                                      ]),
                                    ),
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
                    } else if (state is EmptyFavouriteCharacterListState) {
                      return const Text("No characters has added yet", style: bodySemiBold12);
                    }
                    return Container();
                  }),
                ),
                const Gap(30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Meet the cast", style: bodySemiBold16),
                      GestureDetector(
                          onTap: () {
                            context.read<BottomNavBarCubit>().updateTab(NavigationItem.item2);
                          },
                          child: const ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: BlocBuilder<CharacterCubit, CharacterSate>(builder: (context, state) {
                    if (state is LoadingCharacterState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ResponseCharacterState) {
                      return SizedBox(
                        height: 220,
                        width: width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var data = state.characterModel.data!.characters!.results![index];
                            return CastItemWidget(
                                callBackCastFavourite: () {
                                  context.read<FavouriteCharactersCubit>().addFavouriteCharacter(
                                      id: data.id, name: data.name!, image: data.image!, context: context);
                                },
                                callBackCastDetails: () {
                                  Navigator.of(context).pushNamed('/cast_details');
                                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                    context.read<CastDetailsCubit>().fetchCastDetails(id: int.parse(data.id!));
                                  });
                                },
                                data: data,
                                height: height,
                                width: width);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(24.0);
                          },
                        ),
                      );
                    } else if (state is ErrorCharacterState) {
                      return Center(child: Text(state.error));
                    }
                    return Container();
                  }),
                ),
                const Gap(30.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Locations", style: bodySemiBold16),
                      GestureDetector(onTap: (){
                        context.read<BottomNavBarCubit>().updateTab(NavigationItem.item4);
                      },child: ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: BlocBuilder<LocationCubit, LocationState>(builder: (context, state) {
                    if (state is LoadingLocationState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ResponseLocationState) {
                      return SizedBox(
                        height: 70,
                        width: width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var data = state.locationModel.data!.locations!.results![index];
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
                                          Text("#${data.id}", style: bodyMedium12),
                                          const Gap(5),
                                          Text(data.name ?? "", style: bodyMedium12),
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
                    } else if (state is ErrorLocationState) {
                      return Center(child: Text(state.error));
                    }
                    return Container();
                  }),
                ),
                const Gap(30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Episodes", style: bodySemiBold16),
                      GestureDetector(onTap: (){
                        context.read<BottomNavBarCubit>().updateTab(NavigationItem.item3);
                      },child: ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                Padding(
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
                                          Text("${data.episode}", style: bodyMedium12),
                                          const Gap(5),
                                          Text(data.name ?? "", style: bodyMedium12),
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
                ),
                const Gap(4.0),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

///TODO: Unused codes
/*return GestureDetector(
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
                                                borderRadius:  const BorderRadius.all(Radius.circular(3)),
                                              ),
                                              margin: const EdgeInsets.all(5),
                                              padding: const EdgeInsets.all(2),
                                              child: const Icon(Icons.star, color: AppColors.favouriteColor),
                                            )
                                          ]
                                        ),
                                      ),
                                      const Gap(10),
                                      Text(data.name ?? "", style: bodyMedium12),
                                    ]),
                                  ),
                                ));*/
