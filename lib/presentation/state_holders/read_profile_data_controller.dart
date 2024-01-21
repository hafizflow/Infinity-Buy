import 'package:get/get.dart';
import 'package:infinity_buy/data/models/profile.dart';

import '../../data/services/network_caller.dart';
import '../../data/models/response_data.dart';
import '../../data/utility/urls.dart';

class ReadProfileDataController extends GetxController {
  bool _otpVerifyInProgress = false;
  bool get otpVerifyInProgress => _otpVerifyInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Profile _profile = Profile();
  Profile get profile => _profile;

  bool _isProfileCompleted = false;
  bool get isProfileCompleted => _isProfileCompleted;

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

      if (profileData.isEmpty) {
        _isProfileCompleted = false;
      } else {
        _profile = Profile.fromJson(profileData[0]);
        _isProfileCompleted = true;
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
