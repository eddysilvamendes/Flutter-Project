import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:merceariaonline/src/config/constom_colors.dart';
import 'package:merceariaonline/src/controller/cart_controller.dart';
import 'package:merceariaonline/src/controller/home_controller.dart';
import 'package:merceariaonline/src/controller/navigation_controller.dart';
import 'package:merceariaonline/src/routes/app_routes.dart';
import 'package:merceariaonline/src/screen/common_widgets/custom_shimmer.dart';
import 'package:merceariaonline/src/screen/home/components/category_tile.dart';
import 'package:merceariaonline/src/services/utils_services.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final cartController = Get.find<CartController>();
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();
  final GlobalKey imageGk = GlobalKey();
  final navigationController = Get.find<NavigationController>();
  late Function(GlobalKey) runAddToCardAnimation;
  final searchController = TextEditingController();
  IconData tileIcon = Icons.add_shopping_cart_outlined;
  final UtilsServices utilsServices = UtilsServices();

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    super.initState();
  }

  void itemSelectedCardAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar

      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: ListView(
          children: [
            /*  Container(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: const AppName(),
            ),*/
            //Search box
            GetBuilder<HomeController>(
              builder: (homecontroller) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            homecontroller.searchTitle.value = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: homecontroller
                                    .searchTitle.value.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      searchController.clear();
                                      homecontroller.searchTitle.value = '';
                                      FocusScope.of(context).unfocus();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: CustomColors.customContrastColor,
                                      size: 21,
                                    ),
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            hintText: 'Procure aqui...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: CustomColors.customContrastColor,
                              size: 21,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      padding: const EdgeInsets.only(top: 15, right: 15),
                      child: GetBuilder<CartController>(
                        builder: (cartController) {
                          return GestureDetector(
                            onTap: () {
                              navigationController
                                  .navigatePageView(NavigationTabs.cart);
                            },
                            child: badges.Badge(
                              badgeColor: CustomColors.customContrastColor,
                              badgeContent: Text(
                                cartController.cartItems.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              child: AddToCartIcon(
                                key: globalKeyCartItems,
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: CustomColors.customSwatchColor,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),

            //Categorias
            GetBuilder<HomeController>(
              builder: (homeController) {
                return Container(
                  padding: const EdgeInsets.only(left: 35),
                  height: 40,
                  child: !homeController.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            var categories =
                                homeController.allCategories[index];
                            return CategoryTile(
                              categories: categories.title,
                              isSelected:
                                  categories == homeController.currentCategory,
                              onTap: () {
                                homeController.seletCategory(categories);
                              },
                            );
                          },
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: homeController.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            homeController.allCategories.length,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 12),
                              child: CustomShimmer(
                                height: 20,
                                width: 80,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),

            //Card Content
            GetBuilder<HomeController>(
              builder: (homeController) {
                return SizedBox(
                  height: 500.0,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {},
                    itemCount: homeController.allProducts.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }
                          return Center(
                            child: SizedBox(
                              height: Curves.easeInOut.transform(value) * 500.0,
                              width: Curves.easeInOut.transform(value) * 400.0,
                              child: child,
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              PagesRoutes.productRoutes,
                              arguments: homeController.allProducts[index],
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF32A060),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(2, 4),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                      )
                                    ]),
                                margin: const EdgeInsets.fromLTRB(
                                    10.0, 10.0, 10.0, 30.0),
                                child: Stack(
                                  children: [
                                    //Image
                                    Center(
                                      child: Hero(
                                        tag: homeController
                                            .allProducts[index].imgUrl,
                                        child: Image(
                                          image: NetworkImage(
                                            homeController
                                                .allProducts[index].imgUrl,
                                          ),
                                          height: 280.0,
                                          width: 280.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    //Price Section
                                    Positioned(
                                      top: 30.0,
                                      right: 30.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'FROM',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            '\$${homeController.allProducts[index].price}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Category and Name
                                    Positioned(
                                      left: 30.0,
                                      bottom: 40.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeController
                                                .allProducts[index].unit,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            homeController
                                                .allProducts[index].itemName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Cart Bottom
                              Positioned(
                                bottom: 4.0,
                                child: RawMaterialButton(
                                  padding: const EdgeInsets.all(15.0),
                                  shape: const CircleBorder(),
                                  elevation: 2.0,
                                  fillColor: Colors.black,
                                  child: Icon(
                                    tileIcon,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    switchIcon();
                                    cartController.addItemToCard(
                                        item:
                                            homeController.allProducts[index]);
                                    itemSelectedCardAnimation;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
