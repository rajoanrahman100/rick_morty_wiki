import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownCubit extends Cubit<String?> {

  DropdownCubit() : super(null);

  void selectItem(String value) {
    emit(value);
  }
}
