import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/category_images.dart';

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
            // Category Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                CategoryImages.getImage(place.category.name),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            // Place Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: AppColors.backgroundColor,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          place.location.locality.isNotEmpty
                              ? place.location.locality
                              : place.location.region,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Distance
                      const Icon(
                        Icons.near_me_outlined,
                        size: 14,
                        color: AppColors.backgroundColor,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${place.distance.round()} m away',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                      const Spacer(),
                      // Category
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          place.category.shortName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.backgroundColor,
                          ),
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
