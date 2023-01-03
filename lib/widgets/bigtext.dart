import "package:flutter/material.dart";

import '../ui/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? clr;
  final String txt;
  final TextOverflow? tof;
  final double? fontsize;
  const BigText({
    Key? key,
    required this.txt,
    this.clr = Colors.black,
    this.tof = TextOverflow.ellipsis,
    this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      maxLines: 1,
      style: TextStyle(
        fontSize: fontsize ?? Dimensions.OneUnitHeight * 20,
        overflow: tof,
        color: clr,
        fontWeight: FontWeight.bold,
        fontFamily: "Nunito",
      ),
    );
  }
}
