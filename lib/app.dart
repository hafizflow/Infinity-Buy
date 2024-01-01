import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/ui/screens/splash_screen.dart';
import 'package:infinity_buy/presentation/ui/utility/app_theme_data.dart';

class InfinityBuy extends StatelessWidget {
  const InfinityBuy({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      home: const SplashScreen(),
    );
  }
}
