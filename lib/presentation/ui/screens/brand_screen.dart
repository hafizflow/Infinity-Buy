import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/brand_list_controller.dart';
import 'package:infinity_buy/presentation/ui/widgets/brand_item.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

import '../../state_holders/main_bottom_nav_controller.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        Get.find<MainBottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "Brands",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<BrandListController>().getBrandList();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: GetBuilder<BrandListController>(
              builder: (brandListController) {
                return Visibility(
                  visible: brandListController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        brandListController.brandListModel.brandItem?.length ??
                            0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.95,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: BrandItem(
                          brandListItem: brandListController
                              .brandListModel.brandItem![index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
