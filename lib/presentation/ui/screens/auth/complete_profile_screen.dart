import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/data/models/create_profile_params.dart';
import 'package:infinity_buy/presentation/state_holders/complete_profile_controller.dart';
import 'package:infinity_buy/presentation/state_holders/verify_otp_controller.dart';
import 'package:infinity_buy/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:infinity_buy/presentation/ui/widgets/app_logo.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

// complete profile
class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _stateTEController = TextEditingController();
  final TextEditingController _postCodeTEController = TextEditingController();
  final TextEditingController _countryTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _faxTEController = TextEditingController();
  final TextEditingController _shipNameTEController = TextEditingController();
  final TextEditingController _shipAddTEController = TextEditingController();
  final TextEditingController _shipCityTEController = TextEditingController();
  final TextEditingController _shipStateTEController = TextEditingController();
  final TextEditingController _shipPostCodeTEController =
      TextEditingController();
  final TextEditingController _shipCountryTEController =
      TextEditingController();
  final TextEditingController _shipPhoneTEController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 48),
                const AppLogo(height: 100),
                const SizedBox(height: 24),
                Text(
                  "Complete Profile",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 4),
                Text(
                  "Get started with us with your details",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameTEController,
                  decoration: const InputDecoration(hintText: "Name"),
                  textInputAction: TextInputAction.next,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter name',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _addressTEController,
                  maxLines: 3,
                  decoration: const InputDecoration(hintText: "Address"),
                  textInputAction: TextInputAction.next,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter address',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _cityTEController,
                  decoration: const InputDecoration(hintText: "City"),
                  textInputAction: TextInputAction.next,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter city',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _stateTEController,
                  decoration: const InputDecoration(hintText: "State"),
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter state',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _postCodeTEController,
                  decoration: const InputDecoration(hintText: "PostCode"),
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter postcode',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _countryTEController,
                  decoration: const InputDecoration(hintText: "Country"),
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter country',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _phoneTEController,
                  keyboardType: TextInputType.phone,
                  decoration:
                      const InputDecoration(hintText: "Phone", counterText: ''),
                  textInputAction: TextInputAction.next,
                  maxLength: 11,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter phone number';
                    } else if (val.length != 11) {
                      return 'Enter valid phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _faxTEController,
                  decoration: const InputDecoration(hintText: "Fax"),
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter fax',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _shipNameTEController,
                  decoration: const InputDecoration(hintText: "Ship Name"),
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter ship name',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _shipAddTEController,
                  decoration: const InputDecoration(hintText: "Ship Address"),
                  textInputAction: TextInputAction.done,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Enter ship address',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _shipCityTEController,
                  decoration: const InputDecoration(hintText: "Ship City"),
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter ship city',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _shipStateTEController,
                  decoration: const InputDecoration(hintText: "Ship State"),
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter ship state',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _shipPostCodeTEController,
                  decoration: const InputDecoration(hintText: "Ship Post Code"),
                  textInputAction: TextInputAction.done,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Enter ship post code',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _shipCountryTEController,
                  decoration: const InputDecoration(hintText: "Ship Country"),
                  textInputAction: TextInputAction.done,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Enter ship country',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _shipPhoneTEController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: "Ship Phone", counterText: ''),
                  textInputAction: TextInputAction.next,
                  maxLength: 11,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter ship phone number';
                    } else if (val.length != 11) {
                      return 'Enter valid ship phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CompleteProfileController>(
                    builder: (completeProfileController) {
                      return Visibility(
                        visible: completeProfileController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final createProfileParams = CreateProfileParams(
                                name: _nameTEController.text.trim(),
                                address: _addressTEController.text.trim(),
                                city: _cityTEController.text.trim(),
                                state: _stateTEController.text.trim(),
                                postCode: _postCodeTEController.text.trim(),
                                country: _countryTEController.text.trim(),
                                phone: _phoneTEController.text.trim(),
                                fax: _faxTEController.text.trim(),
                                shipName: _stateTEController.text.trim(),
                                shipAdd: _shipAddTEController.text.trim(),
                                shipCity: _shipCityTEController.text.trim(),
                                shipState: _shipStateTEController.text.trim(),
                                shipPostcode:
                                    _shipPostCodeTEController.text.trim(),
                                shipCountry:
                                    _shipCountryTEController.text.trim(),
                                shipPhone: _shipPhoneTEController.text.trim(),
                              );

                              final bool result =
                                  await completeProfileController
                                      .createProfileData(
                                Get.find<VerifyOtpController>().token,
                                createProfileParams,
                              );

                              if (result) {
                                Get.offAll(() => const MainBottomNavScreen());
                              } else {
                                Get.showSnackbar(GetSnackBar(
                                  title: 'Complete profile failed',
                                  message:
                                      completeProfileController.errorMessage,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                ));
                              }
                            }
                          },
                          child: const Text("Complete"),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _addressTEController.dispose();
    _cityTEController.dispose();
    _stateTEController.dispose();
    _postCodeTEController.dispose();
    _countryTEController.dispose();
    _phoneTEController.dispose();
    _faxTEController.dispose();
    _shipNameTEController.dispose();
    _shipAddTEController.dispose();
    _shipCityTEController.dispose();
    _shipStateTEController.dispose();
    _shipPostCodeTEController.dispose();
    _shipCountryTEController.dispose();
    _shipPhoneTEController.dispose();
  }
}
