import 'dart:developer';

import 'package:flutter/material.dart';
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
  // BottomNavigationController controller = Get.put(BottomNavigationController());
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const WishScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    log("Whole page built");
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  BottomNavigationBar get bottomNavigationBar {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      iconSize: 30,
      onTap: (index) {
        _selectedIndex = index;
        setState(() {});
        // controller.changeTabIndex(index);
      },
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

// class BottomNavigationController extends GetxController {
//   RxInt tabIndex = 0.obs;
//
//   final List<Widget> screen = [
//     const HomeScreen(),
//     const CategoryScreen(),
//     const CartScreen(),
//     const WishScreen(),
//   ];
//
//   void changeTabIndex(int index) {
//     tabIndex.value = index;
//     update();
//   }
// }
