import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_state.dart';
import 'package:ricky_morty_wiki/features/episodes/repository/episode_repository.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  EpisodeCubit() : super(InitialEpisodeState());

  EpisodeRepository episodeRepository = EpisodeRepository();

  Future<void> fetchEpisode() async {
    emit(LoadingEpisodeState());
    try {
      final response = await episodeRepository.getEpisodeList();
      emit(ResponseEpisodeState(response));
    } catch (e) {
      emit(ErrorEpisodeState(e.toString()));
    }
  }
}