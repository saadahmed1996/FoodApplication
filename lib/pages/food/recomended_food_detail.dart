import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/popular_product_controller.dart';
import 'package:flutter_application_1/controllers/recommended_controller.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/utils/app_constants.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/weidgets/app_icon.dart';
import 'package:flutter_application_1/weidgets/big_text.dart';
import 'package:flutter_application_1/weidgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          //Container for Image, two icons (cart & back button) along the recipe name heading
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == 'cartPage') {
                        Get.toNamed(RouterHelper.getCartPage());
                      } else {
                        Get.toNamed(RouterHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                //AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.toNamed(RouterHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                top: 4,
                                right: 5,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ))
                            : Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                  child: BigText(
                    size: Dimensions.font26,
                    text: product.name!,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Description Container in a sliver
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: ExpandableTextWidget(
                    text: product.description!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //bottom nav bar for adding and removing items as well as add more item button.
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //removing items.
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.remove),
                    ),
                    //showing total items
                    BigText(
                      text:
                          " \$ ${product.price!}  X  ${controller.inCartItems} ",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    //adding items.
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.add),
                    ),
                  ],
                ),
              ),
              //bottom Container for fav button icon and add to cart button
              Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Fav icon Button
                    Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    //Add to Cart Button
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        child: BigText(
                          text: "\$ ${product.price!} | Add to cart",
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
