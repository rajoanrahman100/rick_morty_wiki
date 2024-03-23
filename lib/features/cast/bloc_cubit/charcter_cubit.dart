import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/model/character_model.dart';
import 'package:ricky_morty_wiki/features/cast/repository/characters_repository.dart';

class CharacterCubit extends Cubit<CharacterSate> {
  CharacterCubit() : super(InitialCharacterState());

  CharacterRepository characterRepository = CharacterRepository();
  List<CharactersResult> charactersList = [];

  Future<void> fetchCharacters({int? currentPage,String? status,String? query}) async {
    emit(LoadingCharacterState());
    try {
      final response = await characterRepository.getAllCharacters(page: currentPage??1, status: status??"", query: query??"");
      if(query!.isEmpty){
        emit(ResponseCharacterState(response));
      }else{
        emit(ResponseFilteredCharacterState(response));
      }
    } catch (e) {
      emit(ErrorCharacterState(e.toString()));
    }
  }

  void addFavoriteCharacters(CharacterModel characterModel){
    emit(ResponseCharacterState(characterModel));
  }

}
