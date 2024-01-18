import 'package:get/get.dart';

import '../../data/models/network_caller.dart';
import '../../data/services/response_data.dart';
import '../../data/utility/urls.dart';

class ReadProfileDataController extends GetxController {
  bool _otpVerifyInProgress = false;
  bool get otpVerifyInProgress => _otpVerifyInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> readProfileData(String token) async {
    _otpVerifyInProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.readProfile,
      token: token,
    );

    _otpVerifyInProgress = true;

    if (response.isSuccess) {
      final profileData = response.responseData['data'];

      if (profileData == null) {
        update();
        return false;
      } else {
        update();
        return true;
      }
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
