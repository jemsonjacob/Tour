import 'package:flutter/material.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ChoiceChip(
              label: Text(category),
              disabledColor: AppColors.greyColor,
              selected: selectedCategory == category,
              onSelected: (_) {
                onSelected(category);
              },
            ),
          );
        },
      ),
    );
  }
}
