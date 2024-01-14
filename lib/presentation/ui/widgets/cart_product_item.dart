import 'package:flutter/material.dart';

import '../utility/app_colors.dart';
import '../utility/assets_path.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> numberOfItem = ValueNotifier(1);
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.asset(
              AssetsPath.dummyShoePng,
              width: 120,
              height: 115,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Year Special Shoe",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    "Color: Black",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Size: X",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.grey.shade600,
                            size: 26,
                          ),
                          padding: const EdgeInsets.all(2),
                          constraints: const BoxConstraints(),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "\$100",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: numberOfItem,
                          builder: (context, value, _) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: itemCount(numberOfItem, value),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Wrap itemCount(ValueNotifier<int> numberOfItem, int value) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 4,
      children: [
        InkWell(
          onTap: () {
            if (numberOfItem.value > 1) {
              numberOfItem.value--;
            }
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
              color: numberOfItem.value == 1
                  ? AppColors.primaryColor.withOpacity(0.6)
                  : AppColors.primaryColor,
            ),
            child: const Icon(
              Icons.remove,
              size: 14,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          "$value",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () {
            if (numberOfItem.value < 10) {
              numberOfItem.value++;
            }
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
              color: numberOfItem.value == 10
                  ? AppColors.primaryColor.withOpacity(0.6)
                  : AppColors.primaryColor,
            ),
            child: const Icon(
              Icons.add,
              size: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
