import 'package:get/get.dart';
import 'package:infinity_buy/data/models/response_data.dart';
import 'package:infinity_buy/data/services/network_caller.dart';
import 'package:infinity_buy/data/utility/urls.dart';

class RemoveWishController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> removeWish(int id) async {
    _inProgress = true;
    update();

    final ResponseData response =
        await NetworkCaller().getRequest(Urls.removeWish(id));

    _inProgress = false;
    bool isSuccess = false;

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = errorMessage;
    }

    update();
    return isSuccess;
  }
}
