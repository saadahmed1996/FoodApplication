import 'package:flutter_application_1/pages/address/add_address_page.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:flutter_application_1/pages/food/popular_food_detail.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/account/auth/signin_page.dart';
import '../pages/food/recomended_food_detail.dart';

//Giving route name for each page and specific initial and end route which will manage our app state.

//Route Names
class RouterHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signPage = "/sign-In";
  static const String addAddress = "/add-address";

  //Route links
  //Splash Screen Page Route Link
  static String getSplashPage() => '$splashPage';
  //Bottom Nav Bar Home Page Route Link
  static String getInitial() => '$initial';
  //Popular Food Page Route Link
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  //Recommended Food Page Route Link
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  //Cart Page Route Link
  static String getCartPage() => '$cartPage';
  //Sign In Page Route Link
  static String getSignInPage() => '$signPage';
  //Add address
  static String getAddressPage() => '$addAddress';

  //List of routes in Get Page defined along with their name with a fade in Transition property.
  static List<GetPage> routes = [
    //Splash Screen Page
    GetPage(name: splashPage, page: () => SplashScreen()),
    //Bottom Nav Bar Home Page
    GetPage(
      name: initial,
      page: () {
        return HomePage();
      },
      transition: Transition.fade,
    ),
    //Sign In Page
    GetPage(
      name: signPage,
      page: () => SignInPage(),
    ),
    //Popular Food Page
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    //Recommended Food Page
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    //Cart Page
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    //add address
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        }),
  ];
}
