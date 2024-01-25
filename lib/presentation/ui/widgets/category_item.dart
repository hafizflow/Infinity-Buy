import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/data/models/category_list_item.dart';
import 'package:infinity_buy/presentation/ui/screens/product_list_screen.dart';

import '../utility/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final CategoryListItem category;
  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductListScreen(
            category: category.categoryName ?? '',
            categoryId: category.id,
          ),
        );
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                category.categoryImg ?? '',
                width: 50,
              ),
            ),
          ),
          Text(
            category.categoryName ?? '',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
