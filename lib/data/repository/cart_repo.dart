import 'dart:convert';
import 'package:flutter_application_1/models/cart_model.dart';
import 'package:flutter_application_1/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  //set the cart items and set the json to obj
  void addToCartList(List<CartModel> cartList) {
    //SharedPreferences.remove is used to remove data from the local device.
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    var time = DateTime.now();
    cart = [];
    cartList.forEach((element) {
      //Time when the user check out.
      element.time = time.toString();
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    print(sharedPreferences.getStringList(AppConstants.CART_LIST));

    getCartList();
  }

  //In this list we are getting data in json format and converting into the string so we  can use it in th sharedpreferences
  //and save the data locallly in the mobile device so even if the user close the application we can access it and show it to the
  //cart histoty so user can re order from his previous orders.
  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("Inside getCartList " + carts.toString());
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  //Same as above when we were getting the CartList
  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      // cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("History List " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeList();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);

    print('Get the History List ' + getCartHistoryList().length.toString());

    //Getting the time of History food ordered OR check out from user.
    for (int k = 0; k < getCartHistoryList().length; k++) {
      print("The Time for the order is " +
          getCartHistoryList()[k].time.toString());
    }
  }

  void clearCartHistory() {
    removeList();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

  void removeList() {
    //calling cart list to empty it
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
