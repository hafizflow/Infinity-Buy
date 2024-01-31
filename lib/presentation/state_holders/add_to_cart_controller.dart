import 'package:get/get.dart';
import 'package:infinity_buy/data/models/response_data.dart';
import 'package:infinity_buy/data/services/network_caller.dart';

import '../../data/utility/urls.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> addToCart(int productId, String size, String color) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "product_id": productId,
      "color": size,
      "size": color,
    };

    final ResponseData response = await NetworkCaller().postRequest(
      Urls.createCart,
      body: inputParams,
    );

    _inProgress = false;

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
