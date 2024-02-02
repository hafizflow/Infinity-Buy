import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/cart_list_controller.dart';
import 'package:infinity_buy/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:infinity_buy/presentation/ui/utility/app_colors.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

import '../widgets/cart_product_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.find<MainBottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
          ),
          title: const Text("Carts"),
        ),
        body: GetBuilder<CartListController>(builder: (cartListController) {
          return Visibility(
            visible: cartListController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cartListController
                              .cartListModel.cartItemList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return const CartProductItem();
                      },
                    ),
                  ),
                ),
                totalPriceAndCheckOutSection,
              ],
            ),
          );
        }),
      ),
    );
  }

  Container get totalPriceAndCheckOutSection {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "\$1000,000.00",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Checkout"),
            ),
          )
        ],
      ),
    );
  }
}
