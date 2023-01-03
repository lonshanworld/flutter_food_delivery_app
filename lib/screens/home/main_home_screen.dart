import 'package:food_delivery_app/ui/dimensions.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommende_product_controller.dart';
import '../../ui/customColor.dart';
import '../../widgets/bigtext.dart';
import '../../widgets/smalltext.dart';
import "./food_page_body.dart";

import "package:flutter/material.dart";
import "package:get/get.dart";


class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {

  Future<void>_loadedResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: Dimensions.OneUnitHeight * 55,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          SizedBox(width: Dimensions.OneUnitWidth * 20,),
          Container(
            margin: EdgeInsets.only(left: Dimensions.OneUnitWidth * 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const BigText(txt: "Country",clr: CustomColor.ctmMilkGreen,),
                Row(
                  children: <Widget>[
                    const SmallText(txt: "City",clr: Colors.black54,),
                    Icon(Icons.arrow_drop_down_sharp,size: Dimensions.OneUnitHeight * 24,color: CustomColor.ctmMilkGreen,),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.search,size: Dimensions.OneUnitWidth * 35,),
            color: CustomColor.ctmMilkGreen,
            tooltip: 'Search',
            onPressed: () {},
          ),
          SizedBox(width: Dimensions.OneUnitWidth * 30,),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: RefreshIndicator(
        onRefresh: _loadedResource,
        child: Column(
          children: const <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
