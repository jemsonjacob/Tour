import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';

class RecommendationCard extends StatelessWidget {
  final PlaceEntity place;
  const RecommendationCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.gradient1.withAlpha(30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(12),
            //   child: Image.asset(
            //     place.category.iconUrl,
            //     width: 90,
            //     height: 90,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.name, style: AppTextStyles.heading2),
                  const SizedBox(height: 5),
                  Text(place.location.region),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text("${place.distance} Ratings"),
                      const Spacer(),
                      Text(
                        place.category.shortName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
