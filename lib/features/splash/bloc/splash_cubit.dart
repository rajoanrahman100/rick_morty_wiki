import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false); //It calls the constructor of the superclass, which is Cubit<bool>, and initializes it with a default value of false

  void startSplashTimer()  {
    Timer(const Duration(seconds: 3), () {
      emit(true); // Splash screen finished, navigate to main screen
    });
  }
}