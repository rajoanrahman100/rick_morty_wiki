import 'dart:convert';
import 'dart:developer';

import 'package:ricky_morty_wiki/features/cast/model/character_model.dart';
import 'package:ricky_morty_wiki/features/home/model/favourite_character_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static String MY_FAVOURITE_CHARACTERS = "MY_FAVOURITE_CHARACTERS";

  Future<void> saveFavouriteCharacters(List<FavouriteCharactersResult> favouriteCharacters) async {
    log("Saved data: ${favouriteCharacters.length}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedData = jsonEncode(favouriteCharacters);
    prefs.setString(MY_FAVOURITE_CHARACTERS, encodedData);
  }

  Future<List<FavouriteCharactersResult>> loadFavouriteCharacters() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(MY_FAVOURITE_CHARACTERS);

    if (encodedData != null) {
      return (jsonDecode(encodedData) as List).map((data) => FavouriteCharactersResult.fromJson(data)).toList();
    } else {
      return [];
    }
  }
}
