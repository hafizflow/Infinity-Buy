import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/data/models/category_list_item.dart';
import 'package:infinity_buy/presentation/ui/screens/product_list_screen.dart';

import '../utility/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final CategoryListItem categoryListItem;
  const CategoryItem({
    super.key,
    required this.categoryListItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() =>
            ProductListScreen(category: categoryListItem.categoryName ?? ''));
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                categoryListItem.categoryImg ?? '',
                width: 50,
              ),
            ),
          ),
          Text(
            categoryListItem.categoryName ?? '',
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
