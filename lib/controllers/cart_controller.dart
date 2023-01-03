import 'package:food_delivery_app/data/repos/cart_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../ui/customColor.dart';

class CartController extends GetxController{
  final CartRepo cartrepo;
  CartController({
    required this.cartrepo,
  });

  Map<int, CartModel> _items ={};

  //Only for storage and sharedpreference
  List<CartModel> storageItems = [];

  Map<int, CartModel> get items => _items;
  
  void addItem(ProductModel product, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          img: value.img,
          price: value.price,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
          isExist: true,
          product: product,
        );
      });
      if(totalQuantity <= 0){
        _items.remove(product.id);
      }
    }else{
      // print("length of the item is ${_items.length}");
      if(quantity > 0){
        _items.putIfAbsent(product.id!, (){
          // print("adding item to the cart id ${product.id} and quantity is $quantity");
          // _items.forEach((key, value) {
          //   print("quantity is ${value.quantity.toString()}");
          // });
          return CartModel(
            id: product.id,
            name: product.name,
            img: product.img,
            price: product.price,
            quantity: quantity,
            time: DateTime.now().toString(),
            isExist: true,
            product: product,
          );
        });
      }else{
          Get.snackbar(
            "Item Count",
            "You should at least have 1 item !!",
            backgroundColor: CustomColor.ctmErrorbgClr,
            colorText: Colors.white,
          );
      }
    }
    // print("Hello ${getItems[0].name}");
    cartrepo.addtoCartList(getItems);
    // print("Hello ${cartrepo.cart}");
    update();
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
      // print("hi ${e.value.name}");
      return e.value;
    }).toList();
  }

  int get totalAmount{
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartrepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    // print("Length of the item ${storageItems.length}");

    for(int i = 0; i < storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartrepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartrepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel>setItems){
    _items = {};
    _items = setItems;
  }

  void addToCartList(){
    cartrepo.addtoCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartrepo.clearCartHistory();
    update();
  }
}