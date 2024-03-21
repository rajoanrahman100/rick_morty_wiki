import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/app_size.dart';
import 'package:ricky_morty_wiki/core/helper/bg_overlay_image.dart';
import 'package:ricky_morty_wiki/core/helper/custom_appbar.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/character_state.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/charcter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<CharacterCubit>();
      cubit.fetchCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize.initialize(context);
    double? width = AppSize.screenWidth;
    double? height = AppSize.screenHeight;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(),
      body: Stack(alignment: Alignment.center, children: [
        BackgoundImageOverlay(height: height, width: width),
        Container(
          height: height,
          width: width,
          color: AppColors.backgroundColor.withOpacity(0.9),
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              BlocBuilder<CharacterCubit, CharacterSate>(builder: (context, state) {
                if (state is LoadingCharacterState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ResponseCharacterState) {
                  return Container(
                    height: 100,
                    width: width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.characterModel.data!.characters!.results!.length,
                      itemBuilder: (_, index) {
                        var data = state.characterModel.data!.characters!.results![index];
                        return Text(data.name!,style: bodyMedium12.copyWith(color: AppColors.white),);
                      },
                    ),
                  );
                } else if (state is ErrorCharacterState) {
                  return Center(child: Text(state.error));
                }
                return Container();
              })
            ],
          ),
        )
      ]),
    );
  }
}
