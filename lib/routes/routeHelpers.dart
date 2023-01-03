
import 'package:food_delivery_app/screens/address/add_address_screen.dart';
import 'package:food_delivery_app/screens/address/full_map.dart';
import 'package:food_delivery_app/screens/cart/cart_screen.dart';
import 'package:food_delivery_app/screens/home/home_screen.dart';
import 'package:food_delivery_app/screens/payment/individual_payment_screen.dart';
import 'package:food_delivery_app/screens/payment/payment_screen.dart';
import 'package:food_delivery_app/screens/splash/splash_screen.dart';
import "package:get/get.dart";

import '../screens/auth/sign_in.dart';
import '../screens/food/popularfooddetail.dart';
import '../screens/food/recommend_food_detail.dart';

class RouteHelper{
  static const String splashPage = "/splash_page";
  static const String initital = "/";
  static const String popularFood = "/popular_food";
  static const String recommendedFood = "/recommended_food";
  static const String cartPage = "/cart_page";
  static const String signInPage = "/sign_in";
  static const String addAddress = "/add_address";
  static const String fullMap = "/full_map";
  static const String paymentScreen = "/payment_screen";
  static const String individualPaymentScreen = "/individual_payment_screen";

  static String getSplashPage()=> splashPage;
  static String getInitial()=> initital;
  static String getPopularFood(int pageId, String page) => "$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) => "$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage()=> cartPage;
  static String getSignInPage() => signInPage;
  static String getAddressPage(String? addressText, double? lati, double? longi) => "$addAddress?addressText=$addressText&lati=$lati&longi=$longi";
  static String getfullMap(double lat, double lang,String text) => "$fullMap?lat=$lat&lang=$lang&text=$text";
  static String getPaymentPage()=> paymentScreen;
  static String getIndividualPaymentScreen(int uri, String txt) => "$individualPaymentScreen?uri=$uri&txt=$txt";

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: ()=>const SplashPage(),
    ),
    GetPage(name: initital, page: () => const HomePage()),
    GetPage(
      name: popularFood,
      page: (){
        var pageId = Get.parameters["pageId"];
        var page = Get.parameters["page"];
        return PopularFoodDetail(pageId: int.parse(pageId!),page: page!);
      },
      transition:  Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: (){
        var pageId = Get.parameters["pageId"];
        var page = Get.parameters["page"];
        return RecommendFoodDetail(pageId: int.parse(pageId!),page:page!);
      },
      transition:  Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: (){
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signInPage,
      page: (){
        return const SignInPage();
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: addAddress,
      page: (){
        String? addressText = Get.parameters["addressText"];
        String? lati = Get.parameters["lati"];
        String? longi = Get.parameters["longi"];
        return AddAddressScreen(addressText: addressText,lati: double.parse(lati!),longi: double.parse(longi!),);
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: fullMap,
      page: (){
        String lat = Get.parameters["lat"]!;
        String lang = Get.parameters["lang"]!;
        String text = Get.parameters["text"]!;
        return FullMap(lat: double.parse(lat), lang:  double.parse(lang),text: text,);
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: paymentScreen,
      page: (){
        return const PaymentScreen();
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: individualPaymentScreen,
      page: (){
        var uri = Get.parameters["uri"]!;
        String txt = Get.parameters["txt"]!;
        return IndividualPaymentScreen(uri: int.parse(uri), txt: txt);
      },
      transition: Transition.zoom,
    ),
  ];
}
