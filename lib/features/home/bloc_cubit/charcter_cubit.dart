import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/home/repository/characters_repository.dart';

class CharacterCubit extends Cubit<CharacterSate> {
  final CharacterRepository characterRepository;

  CharacterCubit(this.characterRepository) : super(InitialCharacterState());

  Future<void> fetchCharacters() async {
    emit(LoadingCharacterState());
    try {
      final response = await characterRepository.getAllCharacters();
      emit(ResponseCharacterState(response));
    } catch (e) {
      emit(ErrorCharacterState(e.toString()));
    }
  }
}
