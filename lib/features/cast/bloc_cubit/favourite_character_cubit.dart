import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/cast/model/character_model.dart';
import 'package:ricky_morty_wiki/features/cast/model/favourite_character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteCharacterCubit extends Cubit<List<Result>> {
  FavouriteCharacterCubit() : super([]){
    _loadItems();
  }

  void addItem(Result item) {
    final List<Result> currentItems = state;
    currentItems.add(item);
    log("Current items: ${currentItems.length}");
    emit(List<Result>.from(currentItems));
    _saveItems();
  }

  void _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? itemsJson = prefs.getStringList('items');
    if (itemsJson != null) {
      final List<Result> items = itemsJson.map((json) => Result.fromJson(json as Map<String, dynamic>)).toList();
      emit(items);
    }
  }

  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> itemsJson = state.map((item) => item.toJson()).cast<String>().toList();
    prefs.setStringList('items', itemsJson);
  }
}
