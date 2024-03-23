import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/features/splash/bloc/splash_cubit.dart';
import 'package:ricky_morty_wiki/features/splash/screen/splash_screen.dart';

import 'features/bottom_nav_bar/screen/bottom_nav_bar.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, bool>(
      builder: (context, splashFinished) {
        if (!splashFinished) {
          return const SplashScreen();
        } else {
          return BottomNavBarScreen();
        }
      },
    );
  }
}
