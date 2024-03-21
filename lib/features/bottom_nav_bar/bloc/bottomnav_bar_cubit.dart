import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationItem { item1, item2, item3, item4 }

class BottomNavBarCubit extends Cubit<NavigationItem> {
  BottomNavBarCubit() : super(NavigationItem.item1);

  void updateTab(NavigationItem item) => emit(item);
}
