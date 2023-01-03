import 'dart:convert';

import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/global_base/no_data.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import 'package:food_delivery_app/widgets/smalltext.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';
import '../../ui/dimensions.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    // print("BeforegetCartHistoryList ${getCartHistoryList.length}");
    Map<String, int> cartItemsPerOrder = {};

    for(int i = 0; i < getCartHistoryList.length; i ++){
      // print("getCartHistoryList ${getCartHistoryList.length}");
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var ListCounter = 0;

    Widget timeWidget(int index){
      String outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[index].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MMM/dd/yyyy  hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(txt: outputDate);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: CustomColor.ctmMilkGreen,
        automaticallyImplyLeading: false,
        title: const BigText(
          txt: "Cart History",
          clr: Colors.white,
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(Dimensions.OneUnitHeight * 8),
            child: AppIcon(
              icn: Icons.shopping_cart,
              bgClr: CustomColor.primaryBgColor,
              icnClr: CustomColor.ctmMilkGreen,
              icnSize: Dimensions.OneUnitHeight * 22,
            ),
          ),
        ],
      ),
      body:  GetBuilder<CartController>(
        builder: (_cartController){
          return
            _cartController.getCartHistoryList().isNotEmpty ?
            ListView(
              padding: EdgeInsets.only(
                top: Dimensions.OneUnitHeight * 20,
                left: Dimensions.OneUnitWidth * 20,
                right: Dimensions.OneUnitWidth * 20,
                bottom: Dimensions.OneUnitHeight * 60,
              ),
              children: [
                for(int index = 0; index < itemsPerOrder.length; index++) Container(
                  margin: EdgeInsets.only(
                    bottom: Dimensions.OneUnitHeight * 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      timeWidget(ListCounter),
                      // BigText(
                      //   txt: DateFormat("MMM/dd/yyyy  hh:mm a").format(DateTime.parse(getCartHistoryList[ListCounter].time!.toString())),
                      // ),
                      // BigText(
                      //   txt: getCartHistoryList[ListCounter].time!.toString(),
                      // ),
                      // ((){
                      //   var outputFormat = DateFormat("MMM/dd/yyyy  hh:mm a");
                      //   return BigText(txt: outputFormat.format(DateTime.parse(getCartHistoryList[ListCounter].time!)));
                      // }()),
                      SizedBox(height: Dimensions.OneUnitHeight * 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(itemsPerOrder[index], (idx) {
                              if(ListCounter < getCartHistoryList.length){
                                ListCounter++;
                              }
                              return idx <= 2
                                  ?
                              Container(
                                width: Dimensions.OneUnitHeight * 75,
                                height: Dimensions.OneUnitHeight * 75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 8)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.Img_BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[ListCounter - 1].img!,
                                      ),
                                    )
                                ),
                              )
                                  :
                              Container();
                            }),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SmallText(
                                txt: "Total",
                                clr: Colors.black54,
                              ),
                              BigText(
                                txt: "${itemsPerOrder[index]} items",
                                clr: Colors.black54,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(const BorderSide(
                                    color:  CustomColor.ctmMilkGreen,
                                    width: 2,
                                  )),
                                  minimumSize: MaterialStateProperty.all(Size.zero),
                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                                    vertical: Dimensions.OneUnitHeight * 5,
                                    horizontal: Dimensions.OneUnitWidth * 10,
                                  )),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  overlayColor: MaterialStateProperty.all(CustomColor.ctmMilkGreen.withOpacity(0.3)),

                                ),
                                onPressed: (){
                                  var orderTime = cartOrderTimeToList();
                                  Map<int, CartModel> moreOrder = {};
                                  for(int a =0; a < getCartHistoryList.length; a++){
                                    if(getCartHistoryList[a].time == orderTime[index]){
                                      moreOrder.putIfAbsent(getCartHistoryList[a].id!, (){
                                        return CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[a])));
                                      });
                                    }
                                  }
                                  Get.find<CartController>().setItems = moreOrder;
                                  Get.find<CartController>().addToCartList();
                                  Get.toNamed(RouteHelper.getCartPage());
                                },
                                child: SmallText(
                                  txt: "Get More",
                                  clr: CustomColor.ctmMilkGreen,
                                  fontsize: Dimensions.OneUnitHeight * 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
              :
            const NoDataScreen(
              txt: "You didn't buy Anything so far!!",
              imgPath: "assets/images/empty_box.png",
            );
        },
      ),
    );
  }
}
