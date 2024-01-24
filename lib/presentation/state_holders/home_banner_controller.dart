import 'package:get/get.dart';
import 'package:infinity_buy/data/models/banner_list_model.dart';

import '../../data/models/response_data.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class HomeBannerController extends GetxController {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  BannerListModel _bannerListModel = BannerListModel();
  BannerListModel get bannerListModel => _bannerListModel;

  Future<bool> getBannerList() async {
    _inProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.homeBanner,
    );

    bool isSuccess = false;
    _inProgress = false;

    if (response.isSuccess) {
      _bannerListModel = BannerListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
