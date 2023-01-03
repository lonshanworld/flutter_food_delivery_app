import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../../ui/dimensions.dart';
import '../../widgets/bigtext.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const BigText(txt: "Payment",clr: CustomColor.primaryBgColor,),
        backgroundColor: CustomColor.ctmMilkGreen,
      ),
      backgroundColor: CustomColor.primaryBgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getIndividualPaymentScreen( 1, "Paypal Payment"));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/paypal.png",
                  height: Dimensions.OneUnitHeight * 100,
                  // width: double.maxFinite,
                ),
                BigText(txt: "Paypal",clr: Colors.blue.shade900,fontsize: Dimensions.OneUnitWidth * 50,),
              ],
            ),
          ),
          const Divider(height: 5,thickness: 2,),
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getIndividualPaymentScreen( 2, "VISA payment"));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/visa_card.png",
                  height: Dimensions.OneUnitHeight * 100,
                  // width: double.maxFinite,
                ),
                BigText(txt: "VISA",clr: Colors.orange,fontsize: Dimensions.OneUnitWidth * 50,),
              ],
            ),
          ),
          const Divider(height: 5,thickness: 2,),
        ],
      ),
    );
  }
}
