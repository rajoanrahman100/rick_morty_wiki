import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';

import '../constants/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white, // Set the color of the bottom border
            width: 0.5, // Set the width of the bottom border
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Transform.scale(
          scale: .75,
          child: SvgPicture.asset(
            AppAssets.appBarImage,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 70);
}
