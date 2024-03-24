import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_cubit.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/cast_item_widget.dart';

class CharacterListBuilders extends StatelessWidget {
  const CharacterListBuilders({
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
    );
  }
}
