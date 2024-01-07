import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:infinity_buy/presentation/ui/widgets/app_logo.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                decoration: const InputDecoration(hintText: "First Name"),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(hintText: "Last Name"),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: "Mobile"),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(hintText: "City"),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(hintText: "Shipping Address"),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(const MainBottomNavScreen());
                  },
                  child: const Text("Complete"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
