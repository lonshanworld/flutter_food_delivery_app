import 'dart:convert';

// import "package:shared_preferences/shared_preferences.dart";

import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;

  CartRepo({
    required this.sharedPreferences,
  });

  List<String> cart = [];
  List<String> cartHistory=[];

  void addtoCartList(List<CartModel> cartList){
    // sharedPreferences.remove(AppConstants.Cart_List);
    // sharedPreferences.remove(AppConstants.Cart_History_List);
    var time = DateTime.now().toString();
    cart = [];
    // print("Hello ${cart.length}");

    // convert obj to string becoz sharepreference accept only String
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
      // continue;
    }
    // cartList.forEach((element) {
    //   return cart.add(jsonEncode(element));
    // });
    // print("Hello!!!");
    sharedPreferences.setStringList(AppConstants.Cart_List, cart);
    // print(sharedPreferences.getStringList(AppConstants.Cart_List));
    // getCartList();
  }
  
  List<CartModel> getCartList(){
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.Cart_List)){
      carts = sharedPreferences.getStringList(AppConstants.Cart_List)!;
      // print("Inside getcartlist $carts");
    }
    List<CartModel> cartList = [];

    // carts.forEach((element) {
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
    // });
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }


  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.Cart_History_List)){
      cartHistory = sharedPreferences.getStringList(AppConstants.Cart_History_List)!;
    }
    for(int i = 0; i <cart.length; i++){
      // print("History List ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.Cart_History_List, cartHistory);
    // print("The length of history list is ${getCartHistoryList().length}");

    // for(int j = 0; j <getCartHistoryList().length; j++){
    //   print("The Time of history list is ${getCartHistoryList()[j].time}");
    // }
  }


  List<CartModel>getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.Cart_History_List)){
      cartHistory =[];
      cartHistory = sharedPreferences.getStringList(AppConstants.Cart_History_List)!;
    }
    List<CartModel>cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }


  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.Cart_List);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.Cart_History_List);
  }
}