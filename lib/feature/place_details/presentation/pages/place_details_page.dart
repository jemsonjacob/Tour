import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';
import 'package:tourexplorer/feature/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/category_images.dart';
import 'package:tourexplorer/feature/place_details/presentation/widgets/coordinates_card.dart';
import 'package:tourexplorer/feature/place_details/presentation/widgets/place_info.dart';
import 'package:tourexplorer/feature/place_details/presentation/widgets/place_photos.dart';
import 'package:tourexplorer/feature/saved_places/presentation/cubit/is_place_saved_status_cubit.dart';
import 'package:tourexplorer/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final PlaceEntity placeDetails;

  const PlaceDetailsScreen({super.key, required this.placeDetails});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<PlaceSavedStatusCubit>()..checkPlaceSaved(placeDetails.id),
      child: PlaceDetailsView(placeDetails: placeDetails),
    );
  }
}

class PlaceDetailsView extends StatelessWidget {
  final PlaceEntity placeDetails;

  const PlaceDetailsView({super.key, required this.placeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('Place Details'),
        actions: [
          BlocBuilder<PlaceSavedStatusCubit, bool>(
            builder: (context, isPlaceSaved) {
              return IconButton(
                onPressed: () {
                  if (isPlaceSaved) {
                    context.read<PlaceSavedStatusCubit>().removeSavedPlace(
                      placeDetails.id,
                    );
                  } else {
                    context.read<PlaceSavedStatusCubit>().savePlace(
                      placeDetails,
                    );
                  }
                },
                icon: Icon(
                  Icons.bookmark,
                  color: isPlaceSaved ? Colors.red : Colors.grey,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          // Photo
          PlacePhotoCarousel(
            photo: CategoryImages.getImage(placeDetails.category.name),
          ),
          const SizedBox(height: AppSizes.lg),
          // Place name
          Text(
            placeDetails.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor,
            ),
          ),
          const SizedBox(height: 8),
          // Country
          Text(
            placeDetails.location.country,
            style: TextStyle(color: AppColors.greyColor, fontSize: 16),
          ),
          const SizedBox(height: 24),
          // Location
          PlaceInfoCard(
            icon: Icons.location_on_outlined,
            title: 'Location',
            value: placeDetails.location.formattedAddress,
          ),
          const SizedBox(height: 12),
          // Category
          PlaceInfoCard(
            icon: Icons.category_outlined,
            title: 'Category',
            value: placeDetails.category.name,
          ),
          const SizedBox(height: 12),
          // Distance
          PlaceInfoCard(
            icon: Icons.near_me_outlined,
            title: 'Distance',
            value: '${placeDetails.distance.round()} m',
          ),
          const SizedBox(height: 12),
          // Phone
          GestureDetector(
            onTap: () => _callPhone(context),
            child: PlaceInfoCard(
              icon: Icons.phone_outlined,
              title: 'Phone',
              value: placeDetails.phone ?? 'Not Available',
            ),
          ),
          const SizedBox(height: 12),
          // Website
          _buildWebsiteSection(context),
          const SizedBox(height: 24),
          // Coordinates
          CoordinatesCard(
            latitude: placeDetails.latitude,
            longitude: placeDetails.longitude,
          ),
          const SizedBox(height: 8),
          AuthGradientButton(
            buttonText: 'Get Direction',
            onPressed: _getDirection,
          ),
        ],
      ),

      // floatingActionButton: BlocBuilder<PlaceSavedStatusCubit, bool>(
      //   builder: (context, isPlaceSaved) {
      //     return FloatingActionButton(
      //       onPressed: () {
      //         if (isPlaceSaved) {
      //           context.read<PlaceSavedStatusCubit>().removeSavedPlace(
      //             placeDetails.id,
      //           );
      //         } else {
      //           context.read<PlaceSavedStatusCubit>().savePlace(placeDetails);
      //         }
      //       },
      //       child: Icon(
      //         Icons.bookmark,
      //         color: isPlaceSaved ? Colors.red : Colors.grey,
      //       ),
      //     );
      //   },
      // ),
    );
  }

  // WEBSITE
  Widget _buildWebsiteSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _openWebsite(context),
            child: PlaceInfoCard(
              icon: Icons.language_outlined,
              title: 'Website',
              value: placeDetails.website ?? 'Not Available',
            ),
          ),
        ),

        const SizedBox(width: 8),

        _buildCopyButton(context),
      ],
    );
  }

  Widget _buildCopyButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(Icons.copy),
        color: AppColors.backgroundColor,
        tooltip: 'Copy website',
        onPressed: () => _copyWebsite(context),
      ),
    );
  }

  // PHONE
  Future<void> _callPhone(BuildContext context) async {
    final phone = placeDetails.phone;

    if (phone == null || phone.isEmpty) {
      _showMessage(context, 'Phone number not available');
      return;
    }

    final phoneUri = Uri(scheme: 'tel', path: phone);

    if (!await canLaunchUrl(phoneUri)) {
      if (!context.mounted) return;

      _showMessage(context, 'Could not open phone dialer');
      return;
    }

    await launchUrl(phoneUri);
  }

  // Open website
  Future<void> _openWebsite(BuildContext context) async {
    final website = placeDetails.website;

    if (website == null || website.isEmpty) {
      _showMessage(context, 'Website not available');
      return;
    }

    final url = _formatWebsiteUrl(website);
    final websiteUri = Uri.parse(url);

    if (!await canLaunchUrl(websiteUri)) {
      if (!context.mounted) return;

      _showMessage(context, 'Could not open website');
      return;
    }

    await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
  }

  // COPY WEBSITE
  Future<void> _copyWebsite(BuildContext context) async {
    final website = placeDetails.website;

    if (website == null || website.isEmpty) {
      _showMessage(context, 'Website not available');
      return;
    }

    await Clipboard.setData(ClipboardData(text: website));

    if (!context.mounted) return;

    _showMessage(context, 'Website copied');
  }

  // HELPERS
  String _formatWebsiteUrl(String website) {
    final value = website.trim();

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    return 'https://$value';
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)),
      );
  }

  //get direction
  Future<void> _getDirection() async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${placeDetails.latitude},${placeDetails.longitude}',
    );

    await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
  }
}
