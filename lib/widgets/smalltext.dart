import "package:flutter/material.dart";

import '../ui/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? clr;
  final String txt;
  final double? txtheight;
  final double? fontsize;
  const SmallText({
    Key? key,
    required this.txt,
    this.clr = Colors.black,
    this.txtheight,
    this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: fontsize ?? Dimensions.OneUnitWidth * 13,
        height: txtheight ?? Dimensions.OneUnitHeight * 1.2,
        color: clr,
        fontWeight: FontWeight.normal,
        fontFamily: "Nunito",
      ),
    );
  }
}
