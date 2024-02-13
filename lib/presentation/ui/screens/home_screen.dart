import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/auth_controller.dart';
import 'package:infinity_buy/presentation/state_holders/brand_list_controller.dart';
import 'package:infinity_buy/presentation/state_holders/category_controller.dart';
import 'package:infinity_buy/presentation/state_holders/home_banner_controller.dart';
import 'package:infinity_buy/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:infinity_buy/presentation/state_holders/popular_product_controller.dart';
import 'package:infinity_buy/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:infinity_buy/presentation/ui/screens/brand_screen.dart';
import 'package:infinity_buy/presentation/ui/screens/product_list_screen.dart';
import 'package:infinity_buy/presentation/ui/utility/assets_path.dart';
import 'package:infinity_buy/presentation/ui/widgets/brand_item.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

import '../../../data/models/product_model.dart';
import '../../state_holders/new_product_controller.dart';
import '../../state_holders/special_product_controller.dart';
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
                title: 'All Brands',
                onTapSeeAll: () {
                  Get.to(() => const BrandScreen());
                },
              ),
              brandList,
              SectionTitle(
                title: 'Popular',
                onTapSeeAll: () {
                  Get.to(() => const ProductListScreen(
                        categoryId: 1,
                        category: "Popular Products",
                      ));
                },
              ),
              GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                return Visibility(
                  visible: popularProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      popularProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(height: 8),
              SectionTitle(
                title: 'Special',
                onTapSeeAll: () {
                  Get.to(() => const ProductListScreen(
                        categoryId: 1,
                        category: "Special Products",
                      ));
                },
              ),
              GetBuilder<SpecialProductController>(
                  builder: (specialProductController) {
                return Visibility(
                  visible: specialProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      specialProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(height: 8),
              SectionTitle(
                title: 'New',
                onTapSeeAll: () {
                  Get.to(() => const ProductListScreen(
                        categoryId: 1,
                        category: "New Products",
                      ));
                },
              ),
              GetBuilder<NewProductController>(builder: (newProductController) {
                return Visibility(
                  visible: newProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      newProductController.productListModel.productList ?? []),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get brandList {
    return SizedBox(
      height: 130,
      child: GetBuilder<BrandListController>(builder: (brandListController) {
        return Visibility(
          visible: brandListController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount:
                brandListController.brandListModel.brandItem?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BrandItem(
                brandListItem:
                    brandListController.brandListModel.brandItem![index],
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
                category:
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

  SizedBox productList(List<ProductModel> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: productList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCardItem(product: productList[index]);
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
          onTap: () async {
            await AuthController.clearAuthData();
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
            Get.to(() => null);
          },
          iconData: Icons.notifications_active_outlined,
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}
