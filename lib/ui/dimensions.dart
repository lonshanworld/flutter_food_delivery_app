import "package:get/get.dart";

class Dimensions{
  static double screenHeight = Get.context!.height;   // 781
  static double screenWidth = Get.context!.width;   // 392.7

  static double OneUnitHeight = screenHeight / 781.09;
  static double OneUnitWidth = screenWidth / 392.7;
  //
  // static double pageViewHeight = screenHeight / 2.893;
  // static double pageViewContainerHeight = screenHeight / 3.91;
  // static double pageViewTextContainerHeight = screenHeight / 6.508;
}