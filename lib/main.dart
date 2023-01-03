
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommende_product_controller.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:get/get.dart";


import "./helpers/dependencies.dart" as dep;


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.find<PopularProductController>().getPopularProductList();
    // Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_){
        return GetBuilder<RecommendedProductController>(
          builder: (_){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LonShan_ecommerceapp',
              theme: ThemeData(
                backgroundColor: CustomColor.primaryBgColor,
              ),
              // home: MainHomeScreen(),
              initialRoute: RouteHelper.getSplashPage(),
              // home: PaymentScreen(),
              getPages: RouteHelper.routes,
            );
          },
        );
      },
    );
  }
}

