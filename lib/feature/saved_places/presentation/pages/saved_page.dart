import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/destination_card.dart';
import 'package:tourexplorer/feature/place_details/presentation/pages/place_details_page.dart';
import 'package:tourexplorer/feature/saved_places/presentation/bloc/saved_places/saved_bloc.dart';
import 'package:tourexplorer/feature/saved_places/presentation/bloc/saved_places/saved_state.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: BlocBuilder<SavedPlaceBloc, SavedPlacesState>(
          builder: (context, state) {
            if (state is SavedPlaceLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (state is SavedPlaceError) {
              return Center(child: Text(state.message));
            }

            if (state is SavedPlaceLoaded) {
              if (state.places.isEmpty) {
                return const _EmptySavedView();
              }

              return ListView(
                padding: const EdgeInsets.all(AppSizes.md),
                children: [
                  Text('Saved Places', style: AppTextStyles.heading1),
                  const SizedBox(height: 4),
                  const Text(
                    'Your favorite places in one place',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: AppSizes.lg),
                  ...state.places.map(
                    (place) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlaceDetailsScreen(placeDetails: place),
                            ),
                          );
                        },
                        child: DestinationCard(place: place),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _EmptySavedView extends StatelessWidget {
  const _EmptySavedView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.bookmark_border,
              size: 80,
              color: AppColors.greyColor,
            ),
            const SizedBox(height: 16),
            Text('No saved places', style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              'Places you save will appear here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
