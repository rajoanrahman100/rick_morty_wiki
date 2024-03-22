import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/cast/model/character_model.dart';
import 'package:ricky_morty_wiki/features/cast/model/favourite_character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteCharacterCubit extends Cubit<List<CharactersResult>> {
  FavouriteCharacterCubit() : super([]){
    _loadItems();
  }

  void addItem(CharactersResult item) {
    final List<CharactersResult> currentItems = state;
    currentItems.add(item);
    log("Current items: ${currentItems.length}");
    emit(List<CharactersResult>.from(currentItems));
    _saveItems();
  }

  void _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? itemsJson = prefs.getStringList('items');
    if (itemsJson != null) {
      final List<CharactersResult> items = itemsJson.map((json) => CharactersResult.fromJson(json as Map<String, dynamic>)).toList();
      emit(items);
    }
  }

  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> itemsJson = state.map((item) => item.toJson()).cast<String>().toList();
    prefs.setStringList('items', itemsJson);
  }
}
