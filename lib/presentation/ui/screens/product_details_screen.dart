import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/data/models/product_details_data.dart';
import 'package:infinity_buy/presentation/state_holders/add_to_cart_controller.dart';
import 'package:infinity_buy/presentation/state_holders/auth_controller.dart';
import 'package:infinity_buy/presentation/state_holders/product_details_controller.dart';
import 'package:infinity_buy/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:infinity_buy/presentation/ui/screens/review_list_screen.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:infinity_buy/presentation/ui/widgets/product_details/product_image_carousel.dart';

import '../utility/app_colors.dart';
import '../widgets/product_details/color_selector.dart';
import '../widgets/product_details/size_selector.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<int> numberOfItem = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>()
        .getProductDetails(productId: widget.productId);
  }

  bool _isLiked = false;

  String? _selectedSize;
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        return Visibility(
          visible: productDetailsController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageCarousel(
                        urls: [
                          productDetailsController.productDetails.img1 ?? '',
                          productDetailsController.productDetails.img2 ?? '',
                          productDetailsController.productDetails.img3 ?? '',
                          productDetailsController.productDetails.img4 ?? '',
                        ],
                      ),
                      productDetailsBody(
                          productDetailsController.productDetails),
                    ],
                  ),
                ),
              ),
              priceAndAddToCurtSection(
                  productDetailsController.productDetails.product?.price ?? ''),
            ],
          ),
        );
      }),
    );
  }

  Padding productDetailsBody(ProductDetailsData productDetails) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: numberOfItem,
                builder: (context, value, _) {
                  return itemCount(numberOfItem, value);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          reviewAndRating(productDetails.product?.star ?? 0),
          const SizedBox(height: 16),
          const Text(
            "Color",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          ColorSelector(
            colors: productDetails.color
                    ?.split(',')
                    .map((e) => getColorFromString(e))
                    .toList() ??
                [],
            onChange: (selectedColor) {
              _selectedColor = selectedColor;

              log(_selectedColor.toString());
            },
          ),
          const SizedBox(height: 16),
          const Text(
            "Size",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          SizeSelector(
              sizes: productDetails.size?.split(',') ?? [],
              onChange: (selectedSize) {
                _selectedSize = selectedSize;
              }),
          const SizedBox(height: 16),
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            productDetails.des ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Row reviewAndRating(int rating) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 3,
          children: [
            const Icon(
              Icons.star,
              size: 22,
              color: Colors.amber,
            ),
            Text(
              rating.toStringAsPrecision(2),
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () {
            Get.to(
              () => ReviewListScreen(
                productId: widget.productId,
              ),
            );
          },
          child: const Text(
            "Review",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () {
            _isLiked = !_isLiked;
            setState(() {});
          },
          child: Card(
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container priceAndAddToCurtSection(String price) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Price",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '\$$price',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                return Visibility(
                  visible: addToCartController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_selectedColor != null && _selectedSize != null) {
                        if (Get.find<AuthController>().isTokenNotNull) {
                          final stringColor = colorToString(_selectedColor!);
                          bool response = await addToCartController.addToCart(
                            widget.productId,
                            _selectedSize!,
                            stringColor,
                            numberOfItem.value,
                          );
                          if (response) {
                            Get.showSnackbar(const GetSnackBar(
                              title: "Succeed",
                              message: "Successfully added to cart",
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              title: "Failed",
                              message: addToCartController.errorMessage,
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ));
                          }
                        } else {
                          Get.to(() => const VerifyEmailScreen());
                        }
                      } else {
                        Get.showSnackbar(const GetSnackBar(
                          title: "Add to curt failed",
                          message: "Please select color and size",
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: const Text("Add to Cart"),
                  ),
                );
              },
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
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          "$value",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
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
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Color getColorFromString(String color) {
    color = color.toLowerCase();
    if (color == 'red') {
      return Colors.red;
    } else if (color == 'white') {
      return Colors.white;
    } else if (color == 'green') {
      return Colors.green;
    }
    return Colors.grey;
  }

  String colorToString(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.white) {
      return 'White';
    } else if (color == Colors.green) {
      return 'Green';
    }
    return 'Grey';
  }

  // Color getColorFromString(String colorCode) {
  //   String code = colorCode.replaceAll('#', '');
  //   String hexCode = 'FF$code';
  //   return Color(int.parse('0x$hexCode'));
  // }
  //
  // String colorToHashColorCode(String colorCode) {
  //   return colorCode
  //       .toString()
  //       .replaceAll('0xff', '#')
  //       .replaceAll('Color(', '')
  //       .replaceAll(')', '');
  // }
}
