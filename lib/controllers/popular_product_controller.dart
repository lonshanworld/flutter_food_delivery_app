

import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repos/popular_product_repo.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

import '../models/cart_model.dart';
import '../models/product_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isloaded = false;
  bool get isloaded => _isloaded;

  int _quantity=0;
  int get quantity => _quantity;

  // for global amount
  // totalamount
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + quantity;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isloaded = true;
      update();
    }else{

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      // print("plus");
      _quantity = checkQuantity(_quantity + 1);
      // print("increase $_quantity");
    }else{
      // print("minus");
      _quantity = checkQuantity(_quantity - 1);
      // print("decrease $_quantity");
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems + quantity)< 0){
      Get.snackbar(
        "Item Count",
        "You can't Reduce more than 0 !!",
        backgroundColor: CustomColor.ctmErrorbgClr,
        colorText: Colors.white,
      );
      if(_inCartItems > 0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems + quantity) > 99){
      Get.snackbar(
        "Item Count",
        "You can't Add more than 99 !!",
        backgroundColor: CustomColor.ctmErrorbgClr,
        colorText: Colors.white,
      );
      return 99;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    // print("exist or not ${exist.toString()}");
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    // print("the quantity in the cart is ${_inCartItems.toString()}");
  }

  void addItem(ProductModel product){
    // if(_quantity > 0){
      _cart.addItem(product, _quantity,);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);
      // _cart.items.forEach((key, value) {
      //   print("The id is ${value.id} and the quantity is ${value.quantity}");
      // });
    // }
    // else{
    //   Get.snackbar(
    //     "Item Count",
    //     "You should at least have 1 item !!",
    //     backgroundColor: CustomColor.ctmErrorbgClr,
    //     colorText: Colors.white,
    //   );
    // }
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}