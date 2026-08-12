import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/feature/place_details/domain/entities/place_photos_entity.dart';

class PlacePhotoCarousel extends StatelessWidget {
  final List<PlacePhotoEntity> photos;

  const PlacePhotoCarousel({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.greyColor.withAlpha(50),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: AppColors.greyColor,
            ),
            SizedBox(height: 8),
            Text(
              'No photos available',
              style: TextStyle(color: AppColors.greyColor),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              photo.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return Container(
                  color: AppColors.greyColor,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.greyColor.withAlpha(30),
                  child: const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 50,
                      color: AppColors.greyColor,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
