import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';

import 'app_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading1 = TextStyle(
    color: AppColors.backgroundColor,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.primary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.primary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontFamily: AppFonts.primary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: Colors.grey,
    fontFamily: AppFonts.primary,
  );
}
