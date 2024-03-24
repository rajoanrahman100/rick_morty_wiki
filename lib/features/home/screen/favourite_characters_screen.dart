import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_cubit.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_character_state.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/favourite_cast_item_widget.dart';

class FavouriteCharacterScreen extends StatelessWidget {
  const FavouriteCharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initialize(context);
    double? width = AppSize.screenWidth;
    double? height = AppSize.screenHeight;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(isLeading: true),
      body: Stack(
        alignment: Alignment.center,
        children: [
          BackgoundImageOverlay(height: height, width: width),
          Container(
            height: height,
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            color: AppColors.backgroundColor.withOpacity(0.9),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text("Favourite Characters", style: bodySemiBold16.copyWith(color: AppColors.filterBackgroundColor)),
                  ),
                  const Gap(20.0),
                  BlocBuilder<FavouriteCharactersCubit, FavouriteCharactersState>(builder: (context, state) {
                    if (state is InitialFavouriteCharacterState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FavouriteCharacterUpdateState) {
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: buildGridViewCharacters(state, context, height, width, 2),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: buildGridViewCharacters(state, context, height, width, 5),
                          );
                        }
                      });
                    } else if (state is EmptyFavouriteCharacterListState) {
                      return const Center(child: Text("No characters has added yet", style: bodySemiBold12));
                    }
                    return const Center(
                      child: Text(
                        "No Data Found",
                        style: bodySemiBold14,
                      ),
                    );
                  }),
                  const Gap(30.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  GridView buildGridViewCharacters(
      FavouriteCharacterUpdateState state, BuildContext context, double? height, double? width, int? crossAxisCount) {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: crossAxisCount!,
      childAspectRatio: 0.85,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(state.favouriteCharactersList.length, (index) {
        var data = state.favouriteCharactersList[index];
        return FavouriteCastItemWidget(
            callBackCastFavourite: () {
              context.read<FavouriteCharactersCubit>().removeFavouriteCharacter(id: data.id);
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
      }),
    );
  }

}
