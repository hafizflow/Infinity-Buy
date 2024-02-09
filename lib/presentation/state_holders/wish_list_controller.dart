import 'package:get/get.dart';
import 'package:infinity_buy/data/models/response_data.dart';
import 'package:infinity_buy/data/models/wish_list_model.dart';
import 'package:infinity_buy/data/services/network_caller.dart';
import 'package:infinity_buy/data/utility/urls.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  WishListModel _wishListModel = WishListModel();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  WishListModel get wishListModel => _wishListModel;

  Future<bool> getWishList() async {
    _inProgress = true;
    update();

    final ResponseData response =
        await NetworkCaller().getRequest(Urls.wishList);

    _inProgress = false;
    bool isSuccess = false;

    if (response.isSuccess) {
      isSuccess = true;
      _wishListModel = WishListModel.fromJson(response.responseData);
    } else {
      _errorMessage = errorMessage;
    }

    update();
    return isSuccess;
  }
}
