import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning ☀️';
    }

    if (hour < 17) {
      return 'Good Afternoon 🌤';
    }

    return 'Good Evening 🌙';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreeting(),
              style: const TextStyle(color: AppColors.greyColor, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text('Hi, Jemson 👋', style: AppTextStyles.heading1),
          ],
        ),
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.gradient3,
          child: Icon(Icons.person, color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
