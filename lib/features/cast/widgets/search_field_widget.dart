import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/core/constants/app_assets.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/show_snackbar.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/counter_cubit.dart';

import '../bloc_cubit/drop_down_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    showSnackBar(context, "Select item from the dropdown first",Icons.warning_amber);
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
    );
  }
}