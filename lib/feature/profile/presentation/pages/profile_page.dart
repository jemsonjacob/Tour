import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: ListView(
          children: [Text('Profile', style: AppTextStyles.heading1)],
        ),
      ),
    );
  }
}
