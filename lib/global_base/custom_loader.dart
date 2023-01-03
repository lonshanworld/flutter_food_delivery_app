import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import "package:flutter/material.dart";

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.OneUnitHeight * 100,
      width: Dimensions.OneUnitWidth * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 20)),
        color: CustomColor.ctmMilkGreen,
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.black,),
      ),
    );
  }
}
