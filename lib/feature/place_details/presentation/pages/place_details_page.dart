import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/place_details/presentation/bloc/place_details_bloc.dart';
import 'package:tourexplorer/feature/place_details/presentation/widgets/coordinates_card.dart';
import 'package:tourexplorer/feature/place_details/presentation/widgets/place_info.dart';
import 'package:tourexplorer/feature/place_details/presentation/widgets/place_photos.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final PlaceEntity? placeDetails;
  const PlaceDetailsScreen({super.key, this.placeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(title: const Text('Place Details')),
      body: BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
        builder: (context, state) {
          if (state is PlaceDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PlaceDetailsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(state.message, textAlign: TextAlign.center),
              ),
            );
          }

          if (state is PlaceDetailsLoaded) {
            final place = state.place;

            //print(placeDetails);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PlacePhotoCarousel(photos: place.photos),
                const SizedBox(height: AppSizes.lg),
                Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  place.location.country,
                  style: TextStyle(color: AppColors.greyColor, fontSize: 16),
                ),
                const SizedBox(height: 24),
                PlaceInfoCard(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  value: place.location.formattedAddress,
                ),
                const SizedBox(height: 12),
                PlaceInfoCard(
                  icon: Icons.category_outlined,
                  title: 'Category',
                  value: place.category.name,
                ),
                const SizedBox(height: 12),
                PlaceInfoCard(
                  icon: Icons.near_me_outlined,
                  title: 'Distance',
                  value: '${placeDetails!.distance} m',
                ),

                const SizedBox(height: 12),
                PlaceInfoCard(
                  icon: Icons.phone_outlined,
                  title: 'Phone',
                  value: place.phone ?? "Not Available",
                ),

                const SizedBox(height: 12),
                PlaceInfoCard(
                  icon: Icons.language_outlined,
                  title: 'Website',
                  value: place.website ?? "Not Available",
                ),
                const SizedBox(height: 24),

                CoordinatesCard(
                  latitude: place.latitude,
                  longitude: place.longitude,
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
