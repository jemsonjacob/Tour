import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';

class CoordinatesCard extends StatelessWidget {
  const CoordinatesCard({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.greyColor.withAlpha(80),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.map_outlined, color: AppColors.backgroundColor),
                SizedBox(width: 10),
                Text(
                  'Coordinates',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Latitude: $latitude',
              style: TextStyle(color: AppColors.backgroundColor),
            ),
            const SizedBox(height: 4),
            Text(
              'Longitude: $longitude',
              style: TextStyle(color: AppColors.backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
