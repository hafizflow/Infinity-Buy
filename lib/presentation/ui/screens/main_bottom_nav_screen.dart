import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/ui/screens/home_screen.dart';
import 'package:infinity_buy/presentation/ui/screens/wish_screen.dart';
import 'package:infinity_buy/presentation/ui/utility/app_colors.dart';

import 'cart_screen.dart';
import 'category_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    log("Whole page rebuilt");
    return GetBuilder<BottomNavigationController>(builder: (controller) {
      return Scaffold(
        body: controller.screens[controller.tabIndex.value],
        bottomNavigationBar: bottomNavigationBar,
      );
    });
  }

  BottomNavigationBar get bottomNavigationBar {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      currentIndex: controller.tabIndex.value,
      iconSize: 30,
      onTap: controller.changeTabIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.space_dashboard_outlined),
          activeIcon: Icon(Icons.space_dashboard),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline_rounded),
          activeIcon: Icon(Icons.favorite),
          label: "Wish",
        ),
      ],
    );
  }
}

class BottomNavigationController extends GetxController {
  RxInt tabIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const WishScreen(),
  ];

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
