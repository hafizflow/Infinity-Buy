import 'package:infinity_buy/data/models/product_details_data.dart';

class ProductDetailsModel {
  String? msg;
  List<ProductDetailsData>? productDetailsDataList;

  ProductDetailsModel({this.msg, this.productDetailsDataList});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productDetailsDataList = <ProductDetailsData>[];
      json['data'].forEach((v) {
        productDetailsDataList!.add(ProductDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (productDetailsDataList != null) {
      data['data'] = productDetailsDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
