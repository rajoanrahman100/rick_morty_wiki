import 'package:ricky_morty_wiki/features/cast/model/character_model.dart';

abstract class CharacterSate {}

class InitialCharacterState extends CharacterSate {}

class LoadingCharacterState extends CharacterSate {}

class ResponseCharacterState extends CharacterSate {
  final CharacterModel characterModel;

  ResponseCharacterState(this.characterModel);
}

class ErrorCharacterState extends CharacterSate {
  final String error;

  ErrorCharacterState(this.error);
}

class LoadingFilteredCharacterState extends CharacterSate {}

class ResponseFilteredCharacterState extends CharacterSate {
  final CharacterModel characterModel;

  ResponseFilteredCharacterState(this.characterModel);
}

class ErrorFilteredCharacterState extends CharacterSate {
  final String error;

  ErrorFilteredCharacterState(this.error);
}
