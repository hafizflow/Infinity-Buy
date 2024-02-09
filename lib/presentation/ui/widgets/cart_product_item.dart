import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/data/models/cart_item.dart';
import 'package:infinity_buy/presentation/state_holders/cart_list_controller.dart';
import 'package:infinity_buy/presentation/state_holders/delete_cart_controller.dart';

import '../utility/app_colors.dart';

class CartProductItem extends StatefulWidget {
  final CartListItem cartListItem;
  const CartProductItem({
    super.key,
    required this.cartListItem,
  });

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  @override
  Widget build(BuildContext context) {
    late ValueNotifier<int> numberOfItem =
        ValueNotifier(int.parse(widget.cartListItem.qty));
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
              widget.cartListItem.product?.image ?? '',
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
                                widget.cartListItem.product?.title ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Color: ${widget.cartListItem.color}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "Size: ${widget.cartListItem.size}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.find<DeleteCartController>()
                                .deleteCart(widget.cartListItem.productId!);
                            Get.find<CartListController>().getCartList();
                          },
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red.shade200,
                            size: 28,
                          ),
                          constraints: const BoxConstraints(),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "৳${widget.cartListItem.product?.price ?? 0}",
                          style: const TextStyle(
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
                              child: itemCount(numberOfItem),
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

  Wrap itemCount(
    ValueNotifier<int> numberOfItem,
  ) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 4,
      children: [
        InkWell(
          onTap: () {
            if (numberOfItem.value > 1) {
              numberOfItem.value--;
              Get.find<CartListController>().updateQuantity(
                widget.cartListItem.id!,
                numberOfItem.value.toString(),
              );
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
          "${numberOfItem.value}",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () {
            if (numberOfItem.value < 10) {
              numberOfItem.value++;
            }
            Get.find<CartListController>().updateQuantity(
              widget.cartListItem.id!,
              numberOfItem.value.toString(),
            );
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
