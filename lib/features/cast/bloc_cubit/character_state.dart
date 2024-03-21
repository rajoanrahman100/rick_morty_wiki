
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
