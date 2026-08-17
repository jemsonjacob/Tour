import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        color: AppColors.backgroundColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundColor.withValues(alpha: 0.15),
              AppColors.backgroundColor.withValues(alpha: 0.25),
              AppColors.backgroundColor.withValues(alpha: 0.65),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              const Text(
                'Discover',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),

              const Text(
                '& Explore',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Find amazing places and experiences around you.',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
