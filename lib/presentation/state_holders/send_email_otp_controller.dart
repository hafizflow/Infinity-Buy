import 'package:get/get.dart';
import 'package:infinity_buy/data/models/network_caller.dart';
import 'package:infinity_buy/data/services/response_data.dart';

import '../../data/utility/urls.dart';

class SendEmailOtpController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> sendOtpToEmail(String email) async {
    _inProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.sendEmailOtp(email),
    );

    _inProgress = false;

    if (response.isSuccess) {
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
