import 'package:get/get.dart';
import 'package:infinity_buy/data/models/product_details_data.dart';
import 'package:infinity_buy/data/models/product_details_model.dart';

import '../../data/models/response_data.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductDetailsController extends GetxController {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  ProductDetailsModel _productDetailsModel = ProductDetailsModel();
  ProductDetailsData get productDetails =>
      _productDetailsModel.productDetailsDataList!.first;

  Future<bool> getProductDetails({required int productId}) async {
    _inProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.productDetails(productId),
    );

    bool isSuccess = false;
    _inProgress = false;

    if (response.isSuccess) {
      _productDetailsModel =
          ProductDetailsModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
