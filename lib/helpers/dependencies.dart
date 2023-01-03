import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommende_product_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repos/auth_repo.dart';
import 'package:food_delivery_app/data/repos/cart_repo.dart';
import 'package:food_delivery_app/data/repos/location_repo.dart';
import 'package:food_delivery_app/data/repos/popular_product_repo.dart';
import 'package:food_delivery_app/data/repos/recommended_product_repo.dart';
import "package:get/get.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repos/user_repo.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=>sharedPreferences);

  //api Client
  Get.lazyPut(()=>ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences:Get.find(),
  ));
  Get.lazyPut(()=>ApiClient(
    appBaseUrl: AppConstants.Img_BASE_URL,sharedPreferences:Get.find(),
  ));
  Get.lazyPut(()=>ApiClient(
    appBaseUrl: AppConstants.USER_ID,sharedPreferences:Get.find(),
  ));
  Get.lazyPut(()=>ApiClient(
    appBaseUrl: AppConstants.REGISTRATION_SIGNUP_URI,sharedPreferences:Get.find(),
  ));
  Get.lazyPut(()=>ApiClient(
    appBaseUrl: AppConstants.REGISTRATION_SIGNIN_URI,sharedPreferences:Get.find(),
  ));
  Get.lazyPut(()=>ApiClient(
    appBaseUrl: AppConstants.REGISTRATION_TESTING,sharedPreferences:Get.find(),
  ));
  Get.lazyPut(()=>AuthRepo(
    apiClient: Get.find(),
    sharedPreferences: Get.find(),
  ));
  Get.lazyPut(()=>UserRepo(
    apiClient: Get.find(),sharedPreferences: Get.find()
  ));



  //repos
  Get.lazyPut(() => PopularProductRepo(
      apiClient: Get.find()
  ));
  Get.lazyPut(() => RecommendedProductRepo(
      apiClient: Get.find()
  ));
  Get.lazyPut(()=>CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(()=>LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  
  //controller
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));
  Get.lazyPut(()=>UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(
      popularProductRepo: Get.find()
  ));
  Get.lazyPut(() => RecommendedProductController(
      recommendedProductRepo: Get.find()
  ));
  Get.lazyPut(() => CartController(
      cartrepo: Get.find()
  ));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));
}