import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommende_product_controller.dart';
import 'package:food_delivery_app/global_base/no_data.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import 'package:food_delivery_app/widgets/smalltext.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../../ui/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.OneUnitHeight * 40,
            left: Dimensions.OneUnitWidth * 20,
            right: Dimensions.OneUnitWidth * 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icn: Icons.arrow_back_ios_rounded,
                  bgClr: CustomColor.ctmMilkGreen,
                  icnClr: Colors.white,
                  icnSize: Dimensions.OneUnitWidth * 24,
                  fun: (){
                    // Get.back();
                  },
                ),
                SizedBox(width: Dimensions.OneUnitWidth * 100,),
                AppIcon(
                  icn: Icons.home_outlined,
                  bgClr: CustomColor.ctmMilkGreen,
                  icnClr: Colors.white,
                  icnSize: Dimensions.OneUnitWidth * 24,
                  fun: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                ),
                AppIcon(
                  icn: Icons.shopping_cart_outlined,
                  bgClr: CustomColor.ctmMilkGreen,
                  icnClr: Colors.white,
                  icnSize: Dimensions.OneUnitWidth * 24,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (_cartController){
              return
                _cartController.getItems.isNotEmpty
                  ?
                Positioned(
                top: Dimensions.OneUnitHeight * 220,
                left: Dimensions.OneUnitWidth * 20,
                right: Dimensions.OneUnitWidth * 20,
                bottom: 0,
                child: GetBuilder<CartController>(
                  builder: (cartcontroller){
                    var _cartList = cartcontroller.getItems;
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        top: 0,
                        bottom: Dimensions.OneUnitHeight * 100,
                      ),
                      itemCount: _cartList.length,
                      itemBuilder: (_, index){
                        return Container(
                          height: Dimensions.OneUnitHeight * 100,
                          margin: EdgeInsets.only(
                            bottom: Dimensions.OneUnitHeight * 20,
                          ),
                          width: double.maxFinite,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap:(){
                                  var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product);
                                  if(popularIndex >= 0){
                                    Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                  }else{
                                    var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product);
                                    // Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                    if(recommendedIndex < 0){
                                      Get.snackbar(
                                        "History Product",
                                        "Product review is not available for History Products.",
                                        backgroundColor: CustomColor.ctmErrorbgClr,
                                        colorText: Colors.white,
                                      );
                                    }else{
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                    }
                                  }
                                },
                                child: Container(
                                  width: Dimensions.OneUnitHeight * 100,
                                  height: Dimensions.OneUnitHeight * 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 20)),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppConstants.Img_BASE_URL + AppConstants.UPLOAD_URL + _cartList[index].img!
                                        ),
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.OneUnitWidth * 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    BigText(
                                      txt: _cartList[index].name!,
                                    ),
                                    const SmallText(
                                      txt: "Spicy",
                                      clr: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        BigText(
                                          txt: "\$ ${_cartList[index].price}",
                                          clr: Colors.redAccent,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            IconButton(
                                              padding: const EdgeInsets.all(0),
                                              constraints: const BoxConstraints(),
                                              onPressed: (){
                                                cartcontroller.addItem(_cartList[index].product!, -1);
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: Dimensions.OneUnitHeight * 24,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            BigText(
                                              txt: "${_cartList[index].quantity}",
                                              clr: Colors.black54,
                                            ),
                                            IconButton(
                                              padding: const EdgeInsets.all(0),
                                              constraints: const BoxConstraints(),
                                              onPressed: (){
                                                cartcontroller.addItem(_cartList[index].product!, 1);
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: Dimensions.OneUnitHeight * 24,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              )
                  :
                const NoDataScreen(
                  txt: "Your Cart is Empty",
                );
            },
          ),
          GetBuilder<CartController>(
            builder: (cartcontroller){
              return
                cartcontroller.getItems.isNotEmpty
                  ?
                Positioned(
                  top:  Dimensions.OneUnitHeight * 90,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.OneUnitWidth * 25,
                      vertical: Dimensions.OneUnitHeight * 25,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.OneUnitHeight * 40),
                        topRight: Radius.circular(Dimensions.OneUnitHeight * 40),
                        bottomLeft: Radius.circular(Dimensions.OneUnitHeight * 40),
                        bottomRight: Radius.circular(Dimensions.OneUnitHeight * 40),
                      ),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 20)),
                              color: Colors.white
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.OneUnitHeight * 13,
                            horizontal: Dimensions.OneUnitHeight * 13,
                          ),
                          child: BigText(
                            txt: "\$ ${cartcontroller.totalAmount}",
                            clr: Colors.black54,
                            fontsize: Dimensions.OneUnitHeight * 18,
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                              vertical: Dimensions.OneUnitHeight * 13,
                              horizontal: Dimensions.OneUnitWidth * 13,
                            )),
                            backgroundColor: MaterialStateProperty.all(CustomColor.ctmMilkGreen),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 20)),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if(Get.find<AuthController>().userLoggedIn()){
                              if(Get.find<LocationController>().deliAddressList.isEmpty){
                                // print("Hello");
                                Get.toNamed(RouteHelper.getAddressPage("", 0, 0));
                              }
                              else{
                                // print("Bye");
                                cartcontroller.addToHistory();
                              }
                              //
                              // cartcontroller.addToHistory();

                            }else{
                              Get.toNamed(RouteHelper.getSignInPage());
                            }

                          },
                          child: BigText(
                            txt: "Check Out",
                            clr: Colors.white,
                            fontsize: Dimensions.OneUnitHeight * 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                  :
                Container();
            },
          )
        ],
      ),

    );
  }
}
