import 'package:ricky_morty_wiki/features/cast_details/model/cast_details_model.dart';

abstract class CastDetailsState {}

class CastDetailsInitialState extends CastDetailsState {}

class CastDetailsLoadingState extends CastDetailsState {}

class CastDetailsErrorState extends CastDetailsState {
  final String error;
  CastDetailsErrorState(this.error);
}

class CastDetailsLoadedState extends CastDetailsState {

  final CastDetailsModel castDetailsModel;
  CastDetailsLoadedState(this.castDetailsModel);

}
