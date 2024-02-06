import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/review_list_controller.dart';
import 'package:infinity_buy/presentation/ui/screens/create_review_screen.dart';

import '../utility/app_colors.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/review_card.dart';

class ReviewListScreen extends StatefulWidget {
  final int productId;
  const ReviewListScreen({super.key, required this.productId});

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReviewListController>().getReviewList(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Reviews"),
      ),
      body: GetBuilder<ReviewListController>(builder: (reviewListController) {
        if (reviewListController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:
                    reviewListController.reviewListModel.reviewItem?.length ??
                        0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: ReviewCard(
                      reviewListItem: reviewListController
                          .reviewListModel.reviewItem![index],
                    ),
                  );
                },
              ),
            ),
            reviewCountAndAddReview(
                reviewListController.reviewListModel.reviewItem?.length ?? 0),
          ],
        );
      }),
    );
  }

  Container reviewCountAndAddReview(int totalReview) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Reviews",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                const SizedBox(width: 8),
                Text(
                  "($totalReview)",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: () {
                  Get.to(() => const CreateReviewScreen());
                },
                child: const Icon(Icons.add, size: 28),
              ),
            )
          ],
        ),
      ),
    );
  }
}
