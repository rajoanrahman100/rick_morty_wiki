import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';
import 'package:ricky_morty_wiki/core/helper/custom_container_other_item.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_cubit.dart';

import '../../location/bloc_cubit/location_state.dart';

class LocationListBuilder extends StatelessWidget {
  const LocationListBuilder({
    super.key,
    required this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: BlocBuilder<LocationCubit, LocationState>(builder: (context, state) {
        if (state is LoadingLocationState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ResponseLocationState) {
          return SizedBox(
            height: 70,
            width: width,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                var data = state.locationModel.data!.locations!.results![index];
                return CustomPaint(
                  painter: BorderCustomPainter(),
                  child: ClipPath(
                    clipper: CustomAngledBottomRightCorner(),
                    child: SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("#${data.id}", style: bodyMedium12),
                              const Gap(5),
                              Text(data.name ?? "", style: bodyMedium12),
                            ]),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(24.0);
              },
            ),
          );
        } else if (state is ErrorLocationState) {
          return Center(child: Text(state.error));
        }
        return Container();
      }),
    );
  }
}