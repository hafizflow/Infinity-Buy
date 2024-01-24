import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/auth_controller.dart';
import 'package:infinity_buy/presentation/state_holders/category_controller.dart';
import 'package:infinity_buy/presentation/state_holders/home_banner_controller.dart';
import 'package:infinity_buy/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:infinity_buy/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:infinity_buy/presentation/ui/screens/product_list_screen.dart';
import 'package:infinity_buy/presentation/ui/screens/review_screen.dart';
import 'package:infinity_buy/presentation/ui/utility/assets_path.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

import '../widgets/category_item.dart';
import '../widgets/home/circle_icon_button.dart';
import '../widgets/home/banner_carousel.dart';
import '../widgets/home/section_title.dart';
import '../widgets/product_card_item.dart';

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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              searchTextField,
              const SizedBox(height: 16),
              SizedBox(
                height: 210,
                child: GetBuilder<HomeBannerController>(
                    builder: (homeBannerController) {
                  return Visibility(
                    visible: homeBannerController.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: BannerCarousel(
                      bannerList:
                          homeBannerController.bannerListModel.bannerList ?? [],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              SectionTitle(
                title: 'All Categories',
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              categoryList,
              SectionTitle(
                title: 'Popular',
                onTapSeeAll: () {
                  Get.to(() => const ProductListScreen());
                },
              ),
              productList,
              const SizedBox(height: 8),
              SectionTitle(
                title: 'Special',
                onTapSeeAll: () {},
              ),
              productList,
              const SizedBox(height: 8),
              SectionTitle(
                title: 'New',
                onTapSeeAll: () {},
              ),
              productList,
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get categoryList {
    return SizedBox(
      height: 130,
      child: GetBuilder<CategoryController>(builder: (categoryController) {
        return Visibility(
          visible: categoryController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount:
                categoryController.categoryListModel.categoryList?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryItem(
                categoryListItem:
                    categoryController.categoryListModel.categoryList![index],
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(width: 14);
            },
          ),
        );
      }),
    );
  }

  SizedBox get productList {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const ProductCardItem();
        },
        separatorBuilder: (_, __) {
          return const SizedBox(width: 8);
        },
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
        AssetsPath.logoBarPng,
        height: 45,
      ),
      actions: [
        CircleIconButton(
          onTap: () {
            Get.find<AuthController>().clearAuthData();
            Get.offAll(() => const VerifyEmailScreen());
          },
          iconData: Icons.person_2_outlined,
        ),
        const SizedBox(width: 10),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.phone_outlined,
        ),
        const SizedBox(width: 10),
        CircleIconButton(
          onTap: () {
            Get.to(() => const ReviewScreen());
          },
          iconData: Icons.notifications_active_outlined,
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}
