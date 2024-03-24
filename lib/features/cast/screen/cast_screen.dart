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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: AppColors.backgroundColor.withOpacity(0.9),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30.0),
                  Container(
                    height: 55,
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
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _searchController,
                              style: const TextStyle(color: AppColors.white),
                              cursorColor: AppColors.white,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Search",
                                  hintStyle: bodyMedium14.copyWith(color: AppColors.white.withOpacity(0.5)),
                                  contentPadding:
                                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0, bottom: 15.0),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        final dropdownState = context.read<DropdownCubit>().state;
                                        if (dropdownState != AppAssets.nameFilter &&
                                            dropdownState != AppAssets.statusFilter &&
                                            dropdownState != AppAssets.speciesFilter &&
                                            dropdownState != AppAssets.genderFilter) {
                                          showSnackBar(context, "Select item from the dropdown first");
                                        } else {
                                          context
                                              .read<CharacterCubit>()
                                              .fetchCharacters(status: dropdownState, query: _searchController.text);
                                          context.read<CounterCubit>().reset();
                                          print("Value is ${_searchController.text} and item is ${dropdownState}");
                                        }
                                      },
                                      child: const Icon(
                                        Icons.search,
                                        color: AppColors.white,
                                      ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Gap(30.0),
                  Text("All Casts", style: bodySemiBold16.copyWith(color: AppColors.filterBackgroundColor)),
                  const Gap(20.0),
                  BlocBuilder<CharacterCubit, CharacterSate>(builder: (context, state) {
                    if (state is LoadingCharacterState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ResponseCharacterState) {
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return Column(
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
                          );
                        } else {
                          return Column(
                            children: [
                              buildGridViewCharacters(state, context, height, width, 4),
                              const Gap(20.0),
                              BlocBuilder<CounterCubit, int>(
                                builder: (context, state) {
                                  return NextPageCharactersFetch(
                                    value: state,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      });
                    } else if (state is ResponseFilteredCharacterState) {
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return buildGridViewFilteredCharacters(state, context, height, width, 2);
                        } else {
                          // Tab layout
                          return buildGridViewFilteredCharacters(state, context, height, width, 4);
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
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
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
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
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
