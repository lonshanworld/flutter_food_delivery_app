import 'dart:async';

import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommende_product_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController _animationController;

  Future<void>_loadedResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadedResource();
    /*
    Class(){

      NewObject(){
        return data;
      }

    }

    var x = AnyClass()..NewObject();
               (OR)
    var x = AnyClass();
    x = x.NewObject;
     */

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );

    Timer(
      const Duration(seconds: 8),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/images/logo part 1.png",
                width: Dimensions.OneUnitWidth * 250,
              ),
            ),
          ),
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/images/logo part 2.png",
                width: Dimensions.OneUnitWidth * 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
