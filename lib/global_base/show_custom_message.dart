import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

void showCustomSnackbar(String msg,{bool isError=true, String title= "Error"}){
  Get.snackbar(
    title,
    msg,
    duration: const Duration(seconds: 3),
    backgroundColor: isError ? CustomColor.ctmErrorbgClr : CustomColor.ctmSucessbgClr,
    titleText : BigText(txt: title,clr: Colors.white,),
    messageText: Text(msg,style: const TextStyle(color: Colors.white),),
    // colorText: Colors.green,
    snackPosition: SnackPosition.TOP,

  );
}