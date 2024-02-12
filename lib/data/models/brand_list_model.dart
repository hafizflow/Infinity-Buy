import 'brand_list_item.dart';

class BrandListModel {
  String? msg;
  List<BrandListItem>? brandItem;

  BrandListModel({this.msg, this.brandItem});

  BrandListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      brandItem = <BrandListItem>[];
      json['data'].forEach((v) {
        brandItem!.add(BrandListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (brandItem != null) {
      data['data'] = brandItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
