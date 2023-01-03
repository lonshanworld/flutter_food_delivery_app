import 'package:food_delivery_app/widgets/smalltext.dart';
import "package:flutter/material.dart";

import '../ui/customColor.dart';
import '../ui/dimensions.dart';
import 'bigtext.dart';
import 'icon_with_text.dart';

class AppColumn extends StatelessWidget {

  final String txt;
  final double? Bigfntsize;
  const AppColumn({
    Key? key,
    required this.txt,
    this.Bigfntsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BigText(txt: txt, fontsize: Bigfntsize,),
        // SizedBox(
        //   height: Dimensions.OneUnitHeight * 5,
        // ),
        Row(
          children: <Widget>[
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: CustomColor.ctmMilkGreen,
                  size: Dimensions.OneUnitHeight * 16,
                );
              }),
            ),
            SizedBox(
              width: Dimensions.OneUnitWidth * 13,
            ),
            const SmallText(
              txt: "4.5",
              clr: Colors.grey,
            ),
            SizedBox(
              width: Dimensions.OneUnitWidth * 13,
            ),
            const SmallText(
              txt: "1245",
              clr: Colors.grey,
            ),
            SizedBox(
              width: Dimensions.OneUnitWidth * 5,
            ),
            const SmallText(
              txt: "comments",
              clr: Colors.grey,
            ),
          ],
        ),
        // SizedBox(
        //   height: Dimensions.OneUnitHeight * 17,
        // ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            IconWithText(
              txt: "Normal",
              icn: Icons.circle_sharp,
              icnclr: CustomColor.ctmYellowOrange,
            ),
            IconWithText(
              txt: "1.7 km",
              icn: Icons.location_pin,
              icnclr: CustomColor.ctmMilkGreen,
            ),
            IconWithText(
              txt: "32 mins",
              icn: Icons.watch_later_outlined,
              icnclr: CustomColor.ctmsoftRed,
            ),
          ],
        ),
      ],
    );
  }
}
