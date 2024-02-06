import 'package:infinity_buy/data/models/review_item.dart';

class ReviewListModel {
  String? msg;
  List<ReviewListItem>? reviewItem;

  ReviewListModel({this.msg, this.reviewItem});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewItem = <ReviewListItem>[];
      json['data'].forEach((v) {
        reviewItem!.add(ReviewListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (reviewItem != null) {
      data['data'] = reviewItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
