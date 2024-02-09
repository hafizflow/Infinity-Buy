import 'package:infinity_buy/data/models/wish_item.dart';

class WishListModel {
  String? msg;
  List<WishListItem>? wishListItem;

  WishListModel({this.msg, this.wishListItem});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishListItem = <WishListItem>[];
      json['data'].forEach((v) {
        wishListItem!.add(WishListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (wishListItem != null) {
      data['data'] = wishListItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
