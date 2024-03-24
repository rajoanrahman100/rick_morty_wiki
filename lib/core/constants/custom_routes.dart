import 'package:flutter/material.dart';
import 'package:ricky_morty_wiki/app_navigator.dart';
import 'package:ricky_morty_wiki/features/cast_details/screen/cast_details_screen.dart';

Route<dynamic> Function(RouteSettings) customRouteGenerator = (RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) => AppNavigator(),
      );
    case '/cast_details':
      return MaterialPageRoute(
        builder: (context) => CastDetailsScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => AppNavigator(), // Assuming you have an UnknownScreen widget
      );
  }
};
