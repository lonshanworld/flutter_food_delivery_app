
import 'package:food_delivery_app/ui/dimensions.dart';
import "package:flutter/material.dart";

class AppIcon extends StatelessWidget {

  final IconData icn;
  final VoidCallback? fun;
  final Color bgClr;
  final Color icnClr;
  final double icnSize;
  double? padd;
  AppIcon({
    Key? key,
    required this.icn,
    this.fun,
    required this.bgClr,
    required this.icnClr,
    required this.icnSize,
    this.padd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgClr),
        padding: MaterialStateProperty.all(EdgeInsets.all(padd ?? Dimensions.OneUnitWidth * 8)),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(),
        ),
      ),
      child: Icon(icn,size: icnSize,color: icnClr,),
    );
  }
}
