import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _saTEController = TextEditingController();

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
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(hintText: "First Name"),
                  textInputAction: TextInputAction.next,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter first name',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(hintText: "Last Name"),
                  textInputAction: TextInputAction.next,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Enter last name',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _mobileTEController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: "Mobile", counterText: ''),
                  textInputAction: TextInputAction.next,
                  maxLength: 11,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter mobile number';
                    } else if (val.length != 11) {
                      return 'Enter valid mobile number';
                    } else {
                      return null;
                    }
                  },
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
                  controller: _saTEController,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(hintText: "Shipping Address"),
                  textInputAction: TextInputAction.done,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Enter shipping address',
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
                              final bool result =
                                  await completeProfileController
                                      .createProfileData(
                                Get.find<VerifyOtpController>().token,
                                _firstNameTEController.text.trim(),
                                _lastNameTEController.text.trim(),
                                _mobileTEController.text.trim(),
                                _cityTEController.text.trim(),
                                _saTEController.text.trim(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _saTEController.dispose();
    super.dispose();
  }
}
