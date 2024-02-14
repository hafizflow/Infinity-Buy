import 'package:get/get.dart';
import 'package:infinity_buy/data/models/create_review_model.dart';
import 'package:infinity_buy/data/models/response_data.dart';
import 'package:infinity_buy/data/services/network_caller.dart';
import 'package:infinity_buy/data/utility/urls.dart';
import 'package:infinity_buy/presentation/state_holders/auth_controller.dart';

class CreateReviewController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  CreateReviewModel _createReviewModel = CreateReviewModel();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  CreateReviewModel get createReviewModel => _createReviewModel;

  Future<bool> createReview(
      String description, int productId, int rating) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "description": description,
      "product_id": productId,
      "rating": rating
    };

    final ResponseData response = await NetworkCaller().postRequest(
      Urls.createReview,
      body: inputParams,
      token: AuthController.token,
    );

    _inProgress = false;
    if (response.isSuccess) {
      isSuccess = true;
      _createReviewModel = CreateReviewModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
