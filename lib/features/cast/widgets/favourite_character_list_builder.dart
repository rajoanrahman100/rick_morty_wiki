import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container_cast_item.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_cubit.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_character_state.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/cast_item_widget.dart';

class FavouriteCharactersBuilder extends StatelessWidget {
  const FavouriteCharactersBuilder({
    super.key,
    required this.width,
    required this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          padding: const EdgeInsets.all(12.0),
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
    );
  }
}