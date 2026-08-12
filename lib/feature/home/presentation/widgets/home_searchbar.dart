// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tourexplorer/core/custom/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onSearch;

  const HomeSearchBar({super.key, this.controller, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: onSearch,
        cursorColor: AppColors.greyColor,
        style: const TextStyle(fontSize: 13, color: AppColors.backgroundColor),
        decoration: InputDecoration(
          hintText: 'Search places',
          hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 13),

          prefixIcon: Icon(Icons.search, color: AppColors.greyColor, size: 21),
          filled: true,
          fillColor: AppColors.whiteColor,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.greyColor, width: 1),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.greyColor, width: 1),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.greyColor, width: 1),
          ),
        ),
      ),
    );
  }
}
