import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';

import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/counter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/widgets/character_list_builder.dart';
import 'package:ricky_morty_wiki/features/cast/widgets/episode_list_builder.dart';
import 'package:ricky_morty_wiki/features/cast/widgets/favourite_character_list_builder.dart';
import 'package:ricky_morty_wiki/features/cast/widgets/location_list_builder.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_cubit.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_cubit.dart';

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
          padding: const EdgeInsets.all(20.0),
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
                      const Text("Favorites", style: bodySemiBold16),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/favourite');
                          },
                          child: const ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                FavouriteCharactersBuilder(width: width, height: height),
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
                CharacterListBuilders(width: width, height: height),
                const Gap(30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Locations", style: bodySemiBold16),
                      GestureDetector(onTap: (){
                        context.read<BottomNavBarCubit>().updateTab(NavigationItem.item4);
                      },child: const ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                LocationListBuilder(width: width),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Episodes", style: bodySemiBold16),
                      GestureDetector(onTap: (){
                        context.read<BottomNavBarCubit>().updateTab(NavigationItem.item3);
                      },child: const ViewAllContainer()),
                    ],
                  ),
                ),
                const Gap(24),
                EpisodeListBuilder(width: width),
                const Gap(4.0),
              ],
            ),
          ),
        )
      ]),
    );
  }
}



///Widgets that has been used in this screen





