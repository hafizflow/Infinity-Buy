import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinity_buy/data/models/cart_item.dart';
import 'package:infinity_buy/data/models/response_data.dart';
import 'package:infinity_buy/data/services/network_caller.dart';
import 'package:infinity_buy/data/utility/urls.dart';

import '../../data/models/cart_list_model.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  CartListModel _cartListModel = CartListModel();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  CartListModel get cartListModel => _cartListModel;

  Future<bool> getCartList() async {
    _inProgress = true;
    update();

    final ResponseData response =
        await NetworkCaller().getRequest(Urls.cartList);

    log(response.statusCode.toString());
    log(response.errorMessage);

    _inProgress = false;
    bool isSuccess = false;

    if (response.isSuccess) {
      isSuccess = true;
      _cartListModel = CartListModel.fromJson(response.responseData);
      _totalPrice.value = _calculateTotalPrice;
      log(_cartListModel.toString());
    } else {
      _errorMessage = errorMessage;
    }

    update();
    return isSuccess;
  }

  final RxDouble _totalPrice = 0.0.obs;
  RxDouble get totalPrice => _totalPrice;

  void updateQuantity(int id, String quantity) {
    _cartListModel.cartItemList?.firstWhere((element) => element.id == id).qty =
        quantity;
    totalPrice.value = _calculateTotalPrice;
  }

  double get _calculateTotalPrice {
    double total = 0;
    for (CartListItem item in _cartListModel.cartItemList ?? []) {
      total += (double.tryParse(item.product?.price ?? '0') ?? 0) *
          int.parse(item.qty);
    }
    return total;
  }
}
