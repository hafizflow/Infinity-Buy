import 'package:flutter/material.dart';

import '../utility/app_colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: AppColors.primaryColor.withOpacity(0.1),
          child: const Padding(
            padding: EdgeInsets.all(24.0),
            child: Icon(
              Icons.computer,
              color: AppColors.primaryColor,
              size: 32,
            ),
          ),
        ),
        const Text(
          "Electronics",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
