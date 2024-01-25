import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/product_controller.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:infinity_buy/presentation/ui/widgets/product_card_item.dart';

class ProductListScreen extends StatefulWidget {
  final String? category;
  final int? categoryId;

  const ProductListScreen({
    super.key,
    this.category,
    this.categoryId,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      Get.find<ProductController>()
          .getProductList(categoryId: widget.categoryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          widget.category ?? "Products",
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<ProductController>(builder: (productController) {
          return Visibility(
            visible: productController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: Visibility(
              visible:
                  productController.productListModel.productList?.isNotEmpty ??
                      false,
              replacement: const Center(child: Text("No Product found")),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    productController.productListModel.productList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(
                    child: ProductCardItem(
                        product: productController
                            .productListModel.productList![index]),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
