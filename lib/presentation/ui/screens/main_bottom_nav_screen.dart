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
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const WishScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print("Whole page built");
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          if (mounted) {
            setState(() {});
          }
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
      ),
    );
  }
}

// Scaffold(
// bottomNavigationBar: NavigationBarTheme(
// data: NavigationBarThemeData(
// indicatorColor: Colors.transparent,
// backgroundColor: Colors.transparent,
// labelTextStyle: MaterialStateProperty.all(
// const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
// ),
// iconTheme: MaterialStateProperty.all(
// const IconThemeData(size: 30),
// ),
// ),
// child: NavigationBar(
// selectedIndex: index,
// onDestinationSelected: (index) {
// this.index = index;
// setState(() {});
// },
// destinations: const [
// NavigationDestination(
// icon: Icon(Icons.home_outlined),
// selectedIcon: Icon(
// Icons.home,
// color: AppColors.primaryColor,
// ),
// label: "Home",
// ),
// NavigationDestination(
// icon: Icon(Icons.space_dashboard_outlined),
// selectedIcon: Icon(
// Icons.space_dashboard,
// color: AppColors.primaryColor,
// ),
// label: "Categories",
// ),
// NavigationDestination(
// icon: Icon(Icons.shopping_cart_outlined),
// selectedIcon: Icon(
// Icons.shopping_cart,
// color: AppColors.primaryColor,
// ),
// label: "Cart",
// ),
// NavigationDestination(
// icon: Icon(Icons.favorite_outline_rounded),
// selectedIcon: Icon(
// Icons.favorite,
// color: AppColors.primaryColor,
// ),
// label: "Wish",
// ),
// ],
// ),
// ),
// );
