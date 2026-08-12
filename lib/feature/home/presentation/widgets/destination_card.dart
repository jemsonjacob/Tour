import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/get_color.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';

class DestinationCard extends StatelessWidget {
  final PlaceEntity place;

  const DestinationCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            gradient: getGradient(place.id),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  place.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  place.location.locality,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  place.category.shortName,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
