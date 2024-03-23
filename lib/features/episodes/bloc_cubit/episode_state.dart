import 'package:ricky_morty_wiki/features/episodes/model/episode_model.dart';

abstract class EpisodeState {}

class InitialEpisodeState extends EpisodeState {}

class LoadingEpisodeState extends EpisodeState {}

class ErrorEpisodeState extends EpisodeState {
  final String error;
  ErrorEpisodeState(this.error);
}

class ResponseEpisodeState extends EpisodeState {
  final EpisodeModel episodeModel;
  ResponseEpisodeState(this.episodeModel);
}
