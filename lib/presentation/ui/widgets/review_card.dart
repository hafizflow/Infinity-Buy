import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinity_buy/data/models/review_item.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.reviewListItem,
  });
  final ReviewListItem reviewListItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      child: const Icon(
                        CupertinoIcons.person,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      reviewListItem.profile?.cusName ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  reviewListItem.description ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
