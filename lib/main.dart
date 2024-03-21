import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/app_navigator.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/features/bottom_nav_bar/bloc/bottomnav_bar_cubit.dart';
import 'package:ricky_morty_wiki/features/splash/bloc/splash_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashCubit(),
          ),
          BlocProvider(
            create: (context) => BottomNavBarCubit(),
          ),
        ],
        child: AppNavigator(),
      ),
    );
  }
}


///TODO: GraphQL query
/*
//Details of a Character
* query {
  character(id: "1") {
    id
    name
    status
    species
    type
    gender
    origin {
      name
    }
    location {
      name
    }
    image
    episode {

      name

    }
  }
}
*
* */
//List of characters
/*
* query {
  characters(page: 1) {
    results {
      id
      name
      image
    }

* */

///
