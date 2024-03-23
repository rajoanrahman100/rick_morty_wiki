import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_state.dart';
import 'package:ricky_morty_wiki/features/cast_details/repository/cast_details_repository.dart';

class CastDetailsCubit extends Cubit<CastDetailsState> {
  CastDetailsCubit() : super(CastDetailsInitialState());

  CastDetailsRepository castDetailsRepository = CastDetailsRepository();

  Future<void> fetchCastDetails({int? id}) async {
    emit(CastDetailsLoadingState());
    try {
      final response = await castDetailsRepository.getCastDetails(id: id);
      emit(CastDetailsLoadedState(response));
    } catch (e) {
      emit(CastDetailsErrorState(e.toString()));
    }
  }
}
