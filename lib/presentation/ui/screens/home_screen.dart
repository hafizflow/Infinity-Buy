import 'package:flutter/material.dart';
import 'package:infinity_buy/presentation/ui/utility/assets_path.dart';

import '../widgets/home/circle_icon_button.dart';
import '../widgets/home/banner_carousel.dart';
import '../widgets/home/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              searchTextField,
              const SizedBox(height: 16),
              const BannerCarousel(),
              const SizedBox(height: 16),
              SectionTitle(
                title: 'All Categories',
                onTapSeeAll: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField get searchTextField {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: "Search",
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(
        AssetsPath.logoBar,
        height: 45,
      ),
      actions: [
        CircleIconButton(
          onTap: () {},
          iconData: Icons.person_2_outlined,
        ),
        const SizedBox(width: 10),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.phone_outlined,
        ),
        const SizedBox(width: 10),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}
