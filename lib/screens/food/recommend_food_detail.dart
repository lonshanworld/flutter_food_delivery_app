import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommende_product_controller.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import 'package:food_delivery_app/widgets/expandabletext.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../../constants/app_constants.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/routeHelpers.dart';
import '../../ui/dimensions.dart';
import '../../widgets/tinytext.dart';

class RecommendFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icn: Icons.clear_outlined,
                      bgClr: Colors.grey.withOpacity(0.6),
                      icnClr: Colors.black,
                      icnSize: Dimensions.OneUnitHeight * 22,
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
                              icnSize: Dimensions.OneUnitWidth * 22,
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
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(Dimensions.OneUnitHeight * 50),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.OneUnitHeight * 7,
                      horizontal: Dimensions.OneUnitWidth * 20,
                    ),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular( Dimensions.OneUnitHeight * 25),
                          topLeft: Radius.circular( Dimensions.OneUnitHeight * 25),
                        )
                    ),
                    child: Center(
                      child: BigText(
                        txt: product.name,
                        fontsize: Dimensions.OneUnitHeight * 24,
                      ),
                    ),
                  ),
                ),
                backgroundColor: CustomColor.primaryBgColor,
                pinned: true,
                expandedHeight: Dimensions.OneUnitHeight * 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    AppConstants.Img_BASE_URL + AppConstants.UPLOAD_URL + product.img,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.OneUnitHeight * 10,
                    left: Dimensions.OneUnitWidth * 20,
                    right: Dimensions.OneUnitWidth * 20,
                    bottom: Dimensions.OneUnitHeight * 80,
                  ),
                  child: ExpandableTextWidget(
                    longtxt: product.description,
                    fontsize: Dimensions.OneUnitWidth * 14,
                  ),
                ),
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.OneUnitHeight * 5,
              ),
              child: GetBuilder<PopularProductController>(
                builder: (controller){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AppIcon(
                        icn: Icons.remove,
                        bgClr: CustomColor.ctmMilkGreen,
                        icnClr: Colors.white,
                        icnSize: Dimensions.OneUnitHeight * 22,
                        fun: (){
                          controller.setQuantity(false);
                        },
                      ),
                      BigText(
                        txt: "\$ ${product.price} x ${controller.inCartItems}",
                        clr: CustomColor.ctmMilkGreen,
                        fontsize: Dimensions.OneUnitWidth * 26,
                      ),
                      AppIcon(
                        icn: Icons.add,
                        bgClr: CustomColor.ctmMilkGreen,
                        icnClr: Colors.white,
                        icnSize: Dimensions.OneUnitHeight * 22,
                        fun: (){
                          controller.setQuantity(true);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
                horizontal: Dimensions.OneUnitHeight * 5,
              ),
              child: IconButton(
                color: CustomColor.ctmMilkGreen,
                icon: Icon(Icons.favorite,size: Dimensions.OneUnitWidth * 26,),
                onPressed: () {  },
              ),
            ),
            GetBuilder<PopularProductController>(
              builder: (controller){
                return ElevatedButton(
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
                    controller.addItem(product);
                  },
                  child: BigText(
                    txt: "\$ ${product.price * controller.inCartItems} | Add to Cart",
                    clr: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
