import 'package:get/get.dart';
import 'package:infinity_buy/data/services/network_caller.dart';
import 'package:infinity_buy/data/models/response_data.dart';
import 'package:infinity_buy/data/utility/urls.dart';
import 'package:infinity_buy/presentation/state_holders/auth_controller.dart';
import 'package:infinity_buy/presentation/state_holders/read_profile_data_controller.dart';

class VerifyOtpController extends GetxController {
  bool _otpVerifyInProgress = false;
  bool get otpVerifyInProgress => _otpVerifyInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _shouldNavigateCompleteProfile = true;
  bool get shouldNavigateCompleteProfile => _shouldNavigateCompleteProfile;

  String _token = '';
  String get token => _token;

  Future<bool> verifyOTP(String email, String otp) async {
    _otpVerifyInProgress = true;
    update();

    final ResponseData response = await NetworkCaller().getRequest(
      Urls.verifyOtp(email, otp),
    );

    _otpVerifyInProgress = false;

    if (response.isSuccess) {
      _token = response.responseData['data'];

      await Future.delayed(const Duration(seconds: 3));

      final result =
          await Get.find<ReadProfileDataController>().readProfileData(token);

      if (result) {
        _shouldNavigateCompleteProfile =
            Get.find<ReadProfileDataController>().isProfileCompleted == false;
        if (_shouldNavigateCompleteProfile == false) {
          await Get.find<AuthController>().saveUserDetails(
              token, Get.find<ReadProfileDataController>().profile);
        }
      } else {
        _errorMessage = Get.find<ReadProfileDataController>().errorMessage;
        update();
        return false;
      }

      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
