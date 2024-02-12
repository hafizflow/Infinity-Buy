import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/data/models/brand_list_item.dart';
import 'package:infinity_buy/presentation/ui/screens/product_list_screen.dart';

import '../utility/app_colors.dart';

class BrandItem extends StatelessWidget {
  final BrandListItem brandListItem;
  const BrandItem({
    super.key,
    required this.brandListItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductListScreen(
            category: brandListItem.brandName ?? '',
            categoryId: brandListItem.id,
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
                brandListItem.brandImg ?? '',
                width: 50,
              ),
            ),
          ),
          Text(
            brandListItem.brandName ?? '',
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
