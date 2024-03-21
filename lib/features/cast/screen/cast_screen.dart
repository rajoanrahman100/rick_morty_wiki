import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/drop_down_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/favourite_character_cubit.dart';
import 'package:ricky_morty_wiki/features/home/widgets/cast_item_widget.dart';

class CastScreen extends StatefulWidget {
  @override
  State<CastScreen> createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<String> items = [
    'name',
    'status',
    'species',
    'gender',
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
                              return DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Select',
                                      style: bodySemiBold14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((String item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  context.read<DropdownCubit>().selectItem(value!);
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 150,
                                  padding: const EdgeInsets.only(left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      bottomLeft: Radius.circular(24),
                                    ),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: AppColors.filterBackgroundColor,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: AppColors.white,
                                  iconDisabledColor: AppColors.white,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: AppColors.filterBackgroundColor,
                                  ),
                                  //offset: const Offset(-20, 0),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ));
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
                                        print(
                                            "Value is ${_searchController.text} and item is ${context.read<DropdownCubit>().state}");
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
                          return GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            controller: _scrollController,
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(state.characterModel.data!.characters!.results!.length, (index) {
                              var data = state.characterModel.data!.characters!.results![index];
                              return GestureDetector(
                                  onTap: () {
                                    context.read<FavouriteCharacterCubit>().addItem(data);
                                  },
                                  child: CastItemWidget(data: data, height: height, width: width));
                            }),
                          );
                        } else {
                          // Tab layout
                          return GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            crossAxisCount: 4,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            physics: const NeverScrollableScrollPhysics(),
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
