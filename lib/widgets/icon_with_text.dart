import 'package:food_delivery_app/widgets/smalltext.dart';
import "package:flutter/material.dart";

import '../ui/dimensions.dart';

class IconWithText extends StatelessWidget {

  final String txt;
  final Color? txtclr;
  final IconData icn;
  final Color icnclr;

  const IconWithText({
    Key? key,
    required this.txt,
    this.txtclr = Colors.grey,
    required this.icn,
    required this.icnclr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icn, color: icnclr,size: Dimensions.OneUnitHeight * 20,),
        SizedBox(width: Dimensions.OneUnitWidth * 3,),
        SmallText(txt: txt, clr: txtclr,),
      ],
    );
  }
}
