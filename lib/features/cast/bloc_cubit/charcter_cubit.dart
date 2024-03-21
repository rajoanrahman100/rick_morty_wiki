import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/cast/repository/characters_repository.dart';

class CharacterCubit extends Cubit<CharacterSate> {
  final CharacterRepository characterRepository;
  int currentPage = 1;

  CharacterCubit(this.characterRepository) : super(InitialCharacterState());

  Future<void> fetchCharacters({page}) async {
    emit(LoadingCharacterState());
    try {
      final response = await characterRepository.getAllCharacters(currentPage);
      emit(ResponseCharacterState(response));
      currentPage++;
    } catch (e) {
      emit(ErrorCharacterState(e.toString()));
    }
  }
}
