import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:infinity_buy/presentation/ui/utility/app_colors.dart';
import 'package:infinity_buy/presentation/ui/widgets/app_logo.dart';

import '../../../state_holders/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await Get.find<AuthController>().initialize();
    Get.offAll(() => const MainBottomNavScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            SpinKitSpinningLines(color: AppColors.primaryColor),
            SizedBox(height: 16),
            Text("Version 1.0"),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
