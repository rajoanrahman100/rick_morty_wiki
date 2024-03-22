import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/repository/characters_repository.dart';

class CharacterCubit extends Cubit<CharacterSate> {
  CharacterCubit() : super(InitialCharacterState());

  CharacterRepository characterRepository = CharacterRepository();
  int currentPage = 1;

  Future<void> fetchCharacters() async {
    emit(LoadingCharacterState());
    try {
      final response = await characterRepository.getAllCharacters(currentPage);
      emit(ResponseCharacterState(response));
    } catch (e) {
      emit(ErrorCharacterState(e.toString()));
    }
  }

  Future<void> fetchFilteredCharacters({status, query}) async {
    emit(LoadingFilteredCharacterState());
    try {
      final response = await characterRepository.getCharactersFilter(status: status, query: query);
      emit(ResponseFilteredCharacterState(response));
    } catch (e) {
      emit(ErrorFilteredCharacterState(e.toString()));
    }
  }
}
