import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/verify_otp_controller.dart';
import 'package:infinity_buy/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:infinity_buy/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:infinity_buy/presentation/ui/widgets/app_logo.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utility/app_colors.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String email;

  const VerifyOTPScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  late Timer countdownTimer;
  int resendTime = 120;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTEController = TextEditingController();

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      resendTime--;
      if (mounted) {
        setState(() {});
      }
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

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
                const SizedBox(height: 160),
                const AppLogo(height: 100),
                const SizedBox(height: 24),
                Text(
                  "Enter OTP code",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "A 4 digit OTP code has been sent",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  controller: _otpTEController,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 55,
                    activeFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,
                    inactiveColor: AppColors.primaryColor,
                    selectedFillColor: Colors.transparent,
                    selectedColor: Colors.grey.shade600,
                    activeColor: Colors.teal.shade700,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    log("Completed");
                  },
                  appContext: context,
                ),
                const SizedBox(height: 08),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<VerifyOtpController>(
                      builder: (verifyOtpController) {
                    return Visibility(
                      visible: verifyOtpController.otpVerifyInProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool response = await verifyOtpController
                                .verifyOTP(widget.email, _otpTEController.text);

                            if (response) {
                              log("Response: ${response.toString()}");
                              if (verifyOtpController
                                  .shouldNavigateCompleteProfile) {
                                Get.to(() => const CompleteProfileScreen());
                              } else {
                                Get.to(() => const MainBottomNavScreen());
                              }
                            } else {
                              Get.showSnackbar(GetSnackBar(
                                title: 'OTP verification failed',
                                message: verifyOtpController.errorMessage,
                                duration: const Duration(seconds: 2),
                                isDismissible: true,
                              ));
                            }
                          }
                        },
                        child: const Text("Next"),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      const TextSpan(text: "This code will expire "),
                      TextSpan(
                        text: "${resendTime}s",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                resendTime == 0
                    ? TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Resend Code",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
