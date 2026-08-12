import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';

import 'package:tourexplorer/feature/home/presentation/bloc/home_bloc.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/recommendation_card.dart';

class RecommendedPlaces extends StatelessWidget {
  const RecommendedPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded || state.recommendedPlaces.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended For You',
              style: TextStyle(fontSize: 20, color: AppColors.backgroundColor),
            ),
            const SizedBox(height: AppSizes.md),
            ...state.recommendedPlaces.map(
              (place) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RecommendationCard(place: place),
              ),
            ),
          ],
        );
      },
    );
  }
}
