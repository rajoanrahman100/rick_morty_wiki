import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/core/helper/shared_pref_helper.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_character_state.dart';
import 'package:ricky_morty_wiki/features/home/model/favourite_character_result.dart';

class FavouriteCharactersCubit extends Cubit<FavouriteCharactersState> {
  final SharedPrefHelper _sharedPrefHelper;

  FavouriteCharactersCubit(this._sharedPrefHelper) : super(InitialFavouriteCharacterState());

  List<FavouriteCharactersResult> favouriteCharactersList = [];

  void addFavouriteCharacter({id, name, image, context}) async {
    bool itemAlreadyExists = favouriteCharactersList.any((item) => item.id == id);

    if (!itemAlreadyExists) {
      favouriteCharactersList.add(FavouriteCharactersResult(id: id, name: name, image: image));
      log(favouriteCharactersList.length.toString());
      await _sharedPrefHelper.saveFavouriteCharacters(favouriteCharactersList);
      await _sharedPrefHelper.loadFavouriteCharacters();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$name has added to your favourite list")),
      );
      emit(FavouriteCharacterUpdateState(favouriteCharactersList));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$name already been added to your favourite list")),
      );
    }
  }

  void removeFavouriteCharacter({id}) async {
    favouriteCharactersList.removeWhere((element) => element.id == id);
    log(favouriteCharactersList.length.toString());
    await _sharedPrefHelper.saveFavouriteCharacters(favouriteCharactersList);
    await _sharedPrefHelper.loadFavouriteCharacters();
    emit(FavouriteCharacterUpdateState(favouriteCharactersList));
  }

  Future<void> loadObjects() async {
    emit(InitialFavouriteCharacterState());
    favouriteCharactersList = await _sharedPrefHelper.loadFavouriteCharacters();
    if (favouriteCharactersList.isEmpty) {
      emit(EmptyFavouriteCharacterListState());
    } else {
      emit(FavouriteCharacterUpdateState(favouriteCharactersList));
    }
  }
}
