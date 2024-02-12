import 'package:get/get.dart';
import 'package:infinity_buy/data/models/brand_list_model.dart';

import '../../data/models/response_data.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class BrandListController extends GetxController {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  BrandListModel _brandListModel = BrandListModel();
  BrandListModel get brandListModel => _brandListModel;

  Future<bool> getBrandList() async {
    _inProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.brandList,
    );

    bool isSuccess = false;
    _inProgress = false;

    if (response.isSuccess) {
      _brandListModel = BrandListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
