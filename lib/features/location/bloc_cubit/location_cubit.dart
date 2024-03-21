import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_state.dart';
import 'package:ricky_morty_wiki/features/location/repository/location_repository.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepository locationRepository;

  LocationCubit(this.locationRepository) : super(InitialLocationState());

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
