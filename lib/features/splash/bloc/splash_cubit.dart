import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);

  void startSplashTimer() {
    Timer(Duration(seconds: 3), () {
      emit(true); // Splash screen finished, navigate to main screen
    });
  }
}