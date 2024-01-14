import 'package:flutter/material.dart';
import 'package:infinity_buy/presentation/ui/widgets/product_details/product_image_carousel.dart';

import '../utility/app_colors.dart';
import '../widgets/product_details/color_selector.dart';
import '../widgets/product_details/size_selector.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<int> numberOfItem = ValueNotifier(1);
  List<Color> colors = [
    Colors.black,
    Colors.grey.shade400,
    Colors.brown,
    Colors.teal,
    Colors.grey.shade600,
  ];

  List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProductImageCarousel(),
                  productDetailsBody,
                ],
              ),
            ),
          ),
          priceAndAddToCurtSection,
        ],
      ),
    );
  }

  Padding get productDetailsBody {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Happy New Year Special Deal Save 30%",
                  style: TextStyle(
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
          reviewAndRating,
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
            colors: colors,
            onChange: (selectedColor) {},
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
          SizeSelector(sizes: sizes, onChange: (selectedSize) {}),
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
          const Text(
            "In the quiet solitude of the moonlit night, a gentle breeze whispered through the rustling leaves, carrying with it the fragrant aroma of blooming flowers. The ethereal glow of the stars painted a celestial tapestry across the vast expanse of the night sky, creating a breathtaking spectacle that captivated the senses. As the world slept beneath this cosmic masterpiece, a lone owl hooted in the distance, its haunting melody echoing through the stillness.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Row get reviewAndRating {
    return Row(
      children: [
        const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 3,
          children: [
            Icon(
              Icons.star,
              size: 22,
              color: Colors.amber,
            ),
            Text(
              "4.4",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(width: 16),
        const Text(
          "Review",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
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

  Container get priceAndAddToCurtSection {
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
                "Price",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "\$100.00",
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
              child: const Text("Add to Cart"),
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
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
}
