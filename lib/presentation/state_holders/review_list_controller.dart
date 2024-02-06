import 'package:get/get.dart';
import 'package:infinity_buy/data/models/review_list_model.dart';

import '../../data/models/response_data.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ReviewListController extends GetxController {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  ReviewListModel _reviewListModel = ReviewListModel();
  ReviewListModel get reviewListModel => _reviewListModel;

  Future<bool> getReviewList(int productId) async {
    _inProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.reviewList(productId),
    );

    bool isSuccess = false;
    _inProgress = false;

    if (response.isSuccess) {
      _reviewListModel = ReviewListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
