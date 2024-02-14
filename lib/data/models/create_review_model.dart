class CreateReviewModel {
  String? description;
  int? productId;
  int? rating;

  CreateReviewModel({this.description, this.productId, this.rating});

  CreateReviewModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    productId = json['product_id'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['product_id'] = productId;
    data['rating'] = rating;
    return data;
  }
}
