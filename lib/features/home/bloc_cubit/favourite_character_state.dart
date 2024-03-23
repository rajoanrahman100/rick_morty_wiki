import 'package:ricky_morty_wiki/features/cast/model/character_model.dart';
import 'package:ricky_morty_wiki/features/home/model/favourite_character_result.dart';

abstract class FavouriteCharactersState {}

class InitialFavouriteCharacterState extends FavouriteCharactersState {}

class EmptyFavouriteCharacterListState extends FavouriteCharactersState {}

class FavouriteCharacterUpdateState extends FavouriteCharactersState {
  final List<FavouriteCharactersResult> favouriteCharactersList;

  FavouriteCharacterUpdateState(this.favouriteCharactersList);
}

