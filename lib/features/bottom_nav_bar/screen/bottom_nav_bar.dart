import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/features/cast/screen/cast_screen.dart';
import 'package:ricky_morty_wiki/features/episodes/screen/episode_screen.dart';
import 'package:ricky_morty_wiki/features/home/screen/home_screen.dart';
import 'package:ricky_morty_wiki/features/location/screen/location_screen.dart';

import '../bloc_cubit/bottomnav_bar_cubit.dart';

class BottomNavBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: BlocBuilder<BottomNavBarCubit, NavigationItem>(
        builder: (context, currentTab) {
          return _buildBody(currentTab);
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBarCubit, NavigationItem>(
        builder: (context, currentTab) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.white, // Specify your desired color here
                  width: 0.3, // Adjust the width as needed
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: currentTab.index,
              backgroundColor: AppColors.backgroundColor,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.white,

              onTap: (index) {
                final selectedTab = NavigationItem.values[index];
                context.read<BottomNavBarCubit>().updateTab(selectedTab);
              },
              items:  [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: 'Cast',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.video_collection_outlined),
                  label: 'Episode',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.my_location_outlined),
                  label: 'Location',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(NavigationItem currentTab) {
    switch (currentTab) {
      case NavigationItem.item1:
        return HomeScreen();
      case NavigationItem.item2:
        return CastScreen();
      case NavigationItem.item3:
        return EpisodeScreen();
      case NavigationItem.item4:
        return LocationScreen();
      default:
        return Container();
    }
  }
}
