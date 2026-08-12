import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.errorColor.withAlpha(50),
          child: Icon(icon, color: AppColors.errorColor),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}
