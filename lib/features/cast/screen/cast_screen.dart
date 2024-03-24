import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/core/helper/show_snackbar.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/counter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/drop_down_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/widgets/drop_down_widget.dart';
import 'package:ricky_morty_wiki/features/cast/widgets/search_field_widget.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_cubit.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/cast_item_widget.dart';

class CastScreen extends StatefulWidget {
  @override
  State<CastScreen> createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<String> items = [
    AppAssets.nameFilter,
    AppAssets.speciesFilter,
    AppAssets.genderFilter,
    AppAssets.statusFilter
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            color: AppColors.backgroundColor.withOpacity(0.9),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 55,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.white, width: 0.2),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          BlocBuilder<DropdownCubit, String?>(
                            builder: (context, selectedValue) {
                              return DropDownButtonWidget(items: items, selectedValue: selectedValue);
                            },
                          ),
                          SearchField(searchController: _searchController)
                        ],
                      ),
                    ),
                  ),
                  const Gap(30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text("All Casts", style: bodySemiBold16.copyWith(color: AppColors.filterBackgroundColor)),
                  ),
                  const Gap(20.0),
                  BlocBuilder<CharacterCubit, CharacterSate>(builder: (context, state) {
                    if (state is LoadingCharacterState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ResponseCharacterState) {
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Column(
                              children: [
                                buildGridViewCharacters(state, context, height, width, 2),
                                const Gap(20.0),
                                BlocBuilder<CounterCubit, int>(
                                  builder: (context, state) {
                                    return NextPageCharactersFetch(
                                      value: state,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Column(
                              children: [
                                buildGridViewCharacters(state, context, height, width, 5),
                                const Gap(20.0),
                                BlocBuilder<CounterCubit, int>(
                                  builder: (context, state) {
                                    return NextPageCharactersFetch(
                                      value: state,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      });
                    } else if (state is ResponseFilteredCharacterState) {
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return buildGridViewFilteredCharacters(state, context, height, width, 2);
                        } else {
                          // Tab layout
                          return buildGridViewFilteredCharacters(state, context, height, width, 5);
                        }
                      });
                    } else if (state is ErrorCharacterState) {
                      return Center(child: Text(state.error));
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
      ResponseCharacterState state, BuildContext context, double? height, double? width, int? crossAxisCount) {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: crossAxisCount!,

      childAspectRatio: 0.85,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(state.characterModel.data!.characters!.results!.length, (index) {
        var data = state.characterModel.data!.characters!.results![index];
        return CastItemWidget(
            callBackCastFavourite: () {
              context
                  .read<FavouriteCharactersCubit>()
                  .addFavouriteCharacter(id: data.id, name: data.name!, image: data.image!, context: context);
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

  GridView buildGridViewFilteredCharacters(
      ResponseFilteredCharacterState state, BuildContext context, double? height, double? width, int? crossAxisCount) {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,

      crossAxisCount: crossAxisCount!,
      childAspectRatio: 0.85,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(state.characterModel.data!.characters!.results!.length, (index) {
        var data = state.characterModel.data!.characters!.results![index];
        return CastItemWidget(
            callBackCastFavourite: () {
              context
                  .read<FavouriteCharactersCubit>()
                  .addFavouriteCharacter(id: data.id, name: data.name!, image: data.image!, context: context);
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



class NextPageCharactersFetch extends StatelessWidget {
  NextPageCharactersFetch({
    required this.value,
  });

  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        value == 1
            ? const Text("")
            : GestureDetector(
                onTap: () {
                  context.read<CounterCubit>().decrement();
                  value--;

                  context.read<CharacterCubit>().fetchCharacters(currentPage: value, status: "name", query: "");
                },
                child: const Text("< prev", style: bodySemiBold14)),
        Text("page : $value", style: bodySemiBold14),
        value >= 42
            ? const Text("")
            : GestureDetector(
                onTap: () {
                  context.read<CounterCubit>().increment();
                  value++;

                  context.read<CharacterCubit>().fetchCharacters(currentPage: value, status: "name", query: "");
                },
                child: const Text("next >", style: bodySemiBold14)),
      ],
    );
  }
}
