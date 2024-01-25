import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/category_controller.dart';
import 'package:infinity_buy/presentation/ui/widgets/category_item.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

import '../../state_holders/main_bottom_nav_controller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
              Get.find<MainBottomNavController>().backToHome();
            },
          ),
          title: const Text(
            "Category",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoryController>().getCategoryList();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: GetBuilder<CategoryController>(
              builder: (categoryController) {
                return Visibility(
                  visible: categoryController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: categoryController
                            .categoryListModel.categoryList?.length ??
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
                        child: CategoryItem(
                          category: categoryController
                              .categoryListModel.categoryList![index],
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
