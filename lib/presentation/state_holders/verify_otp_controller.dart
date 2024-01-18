import 'package:get/get.dart';
import 'package:infinity_buy/data/models/network_caller.dart';
import 'package:infinity_buy/data/services/response_data.dart';
import 'package:infinity_buy/data/utility/urls.dart';

class VerifyOtpController extends GetxController {
  bool _otpVerifyInProgress = false;
  bool get otpVerifyInProgress => _otpVerifyInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _shouldNavigateCompleteProfile = true;
  bool get shouldNavigateCompleteProfile => _shouldNavigateCompleteProfile;

  Future<bool> verifyOTP(String email, String otp) async {
    _otpVerifyInProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.verifyOtp(email, otp),
    );

    _otpVerifyInProgress = true;

    if (response.isSuccess) {
      final token = response.responseData['data'];

      _shouldNavigateCompleteProfile;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
