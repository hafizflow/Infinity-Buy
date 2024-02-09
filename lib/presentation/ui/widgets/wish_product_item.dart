import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/data/models/wish_item.dart';
import 'package:infinity_buy/presentation/state_holders/remove_wish_controller.dart';
import 'package:infinity_buy/presentation/state_holders/wish_list_controller.dart';

import '../utility/app_colors.dart';

class WishProductItem extends StatefulWidget {
  final WishListItem wishItem;
  const WishProductItem({
    super.key,
    required this.wishItem,
  });

  @override
  State<WishProductItem> createState() => _WishProductItemState();
}

class _WishProductItemState extends State<WishProductItem> {
  @override
  Widget build(BuildContext context) {
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
            child: Image.network(
              widget.wishItem.product?.image ?? '',
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
                                widget.wishItem.product?.title ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.find<RemoveWishController>()
                                .removeWish(widget.wishItem.productId!);
                            Get.find<WishListController>().getWishList();
                          },
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red.shade200,
                            size: 28,
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
                        Text(
                          "৳${widget.wishItem.product?.price ?? 0}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
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
}
