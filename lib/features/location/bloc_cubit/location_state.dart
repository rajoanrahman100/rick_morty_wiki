import 'package:ricky_morty_wiki/features/location/model/location_model.dart';

abstract class LocationState {}

class InitialLocationState extends LocationState {}

class LoadingLocationState extends LocationState {}

class ResponseLocationState extends LocationState {
  final LocationModel locationModel;
  ResponseLocationState(this.locationModel);
}

class ErrorLocationState extends LocationState {
  final String error;
  ErrorLocationState(this.error);
}
