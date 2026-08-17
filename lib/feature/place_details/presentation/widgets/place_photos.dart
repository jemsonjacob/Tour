import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';

class PlacePhotoCarousel extends StatelessWidget {
  final String photo;
  const PlacePhotoCarousel({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    if (photo.isEmpty) {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(photo, width: 90, height: 90, fit: BoxFit.cover),
      ),
    );
  }
}
