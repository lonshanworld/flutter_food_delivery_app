import 'package:food_delivery_app/ui/dimensions.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import "package:flutter/material.dart";

class NoDataScreen extends StatelessWidget {

  final String txt;
  final String imgPath;
  const NoDataScreen({
    Key? key,
    required this.txt,
    this.imgPath = "assets/images/empty_cart.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          imgPath,
          height: Dimensions.OneUnitHeight * 200,
          width: double.maxFinite,
        ),
        SizedBox(
          height: Dimensions.OneUnitHeight * 30,
        ),
        BigText(txt: txt,clr: Colors.grey,),
      ],
    );
  }
}
