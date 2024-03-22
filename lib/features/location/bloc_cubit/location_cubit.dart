import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_state.dart';
import 'package:ricky_morty_wiki/features/location/repository/location_repository.dart';

class LocationCubit extends Cubit<LocationState> {


  LocationCubit() : super(InitialLocationState());

  LocationRepository locationRepository = LocationRepository();

  Future<void> fetchLocations() async {
    emit(LoadingLocationState());
    try {
      final response = await locationRepository.getAllLocations();
      emit(ResponseLocationState(response));
    } catch (e) {
      emit(ErrorLocationState(e.toString()));
    }
  }
}
