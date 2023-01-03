import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import "package:flutter/material.dart";

class TinyText extends StatelessWidget {

  final String txt;
  const TinyText({
    Key? key,
    required this.txt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.OneUnitWidth * 5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColor.ctmMilkGreen,
      ),
      child: Text(
        txt,
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: Dimensions.OneUnitWidth * 11,
          color: Colors.white,
        ),
      ),
    );
  }
}
