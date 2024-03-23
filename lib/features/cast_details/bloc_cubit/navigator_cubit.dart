import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatorCubit extends Cubit<dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorCubit({required this.navigatorKey}) : super(0);

  void pop() {
    emit(null); // You can emit any value, it's not relevant for this Cubit
    navigatorKey.currentState?.pop();
  }

  void navigateToHome() {
    emit(null); // You can emit any value, it's not relevant for this Cubit
    navigatorKey.currentState?.pushNamed('/second');
  }
}