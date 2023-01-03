import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/expandabletext.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../../widgets/bigtext.dart';
import '../../widgets/tinytext.dart';
class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    // print("page is id" + pageId.toString());
    // print("Product name is" + product.name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // backgroun image
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.OneUnitHeight * 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.Img_BASE_URL + AppConstants.UPLOAD_URL + product.img,
                  ),
                )
              ),
            ),
          ),

          // icon widget
          Positioned(
            top: Dimensions.OneUnitHeight * 50,
            left: Dimensions.OneUnitWidth * 20,
            right: Dimensions.OneUnitWidth * 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AppIcon(
                  icn: Icons.arrow_back_rounded,
                  bgClr: Colors.grey.withOpacity(0.6),
                  icnClr: Colors.black,
                  icnSize: Dimensions.OneUnitWidth * 25,
                  fun: (){
                    if(page == "cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                ),
                GetBuilder<PopularProductController>(
                  builder: (numcontroller){
                    return Stack(
                      children: [
                        AppIcon(
                          icn: Icons.shopping_cart_outlined,
                          bgClr: Colors.grey.withOpacity(0.6),
                          icnClr: Colors.black,
                          icnSize: Dimensions.OneUnitWidth * 25,
                          fun: (){
                            if(numcontroller.totalItems > 0) Get.toNamed(RouteHelper.getCartPage());
                          },
                        ),
                        if(Get.find<PopularProductController>().totalItems > 0) Positioned(
                          right: Dimensions.OneUnitWidth * 8,
                          top : 0,
                          child: TinyText(
                            txt: Get.find<PopularProductController>().totalItems.toString(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top:  Dimensions.OneUnitHeight * 320,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.OneUnitWidth * 15,
                right: Dimensions.OneUnitWidth * 15,
                top: Dimensions.OneUnitHeight * 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.OneUnitWidth * 20),
                  topLeft:  Radius.circular(Dimensions.OneUnitWidth * 20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.OneUnitHeight * 100,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.OneUnitHeight * 5,
                        right: Dimensions.OneUnitWidth * 10,
                        left: Dimensions.OneUnitWidth * 10,
                        bottom: Dimensions.OneUnitHeight * 10,
                      ),
                      child: AppColumn(txt: product.name,Bigfntsize: Dimensions.OneUnitHeight * 26,),
                    ),
                  ),
                  SizedBox(height: Dimensions.OneUnitHeight * 15,),
                  const BigText(txt: "Introduction"),
                  SizedBox(height: Dimensions.OneUnitHeight * 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          longtxt: product.description),
                    ),
                  ),
                  // ExpandableTextWidget(longtxt: "Hahahahahahaha"),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularproduct){
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.OneUnitWidth * 25,
              vertical: Dimensions.OneUnitHeight * 25,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.OneUnitHeight * 40),
                topRight: Radius.circular(Dimensions.OneUnitHeight * 40),
              ),
              color: CustomColor.primaryBgColor,
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
                    vertical: Dimensions.OneUnitHeight * 5,
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          popularproduct.setQuantity(false);
                        },
                        icon: Icon(Icons.remove, color: Colors.black54, size: Dimensions.OneUnitHeight * 24,),
                      ),
                      BigText(txt: popularproduct.inCartItems.toString(),clr: Colors.black54,),
                      IconButton(
                        onPressed: (){
                          popularproduct.setQuantity(true);
                        },
                        icon: Icon(Icons.add, color:Colors.black54, size: Dimensions.OneUnitHeight * 24,),
                      ),
                    ],
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
                    popularproduct.addItem(product);
                  },
                  child:BigText(
                    txt: "\$ ${product.price * popularproduct.inCartItems} | Add to Cart",
                    clr: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
